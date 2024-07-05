import json
from django.http import JsonResponse
from django.shortcuts import render
from .models import Clientes
from inventario.models import Inventario
from produccion.models import OrdenProduccion, TransaccionOrden, Transformulas
from formulas.models import TransMp 
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
def facturar(request):
    clientes = Clientes.objects.all()
    productos = Inventario.objects.all()
    
    
    return render(request, 'facturacion.html',{'clientes': clientes , 'productos': productos})


def obtenerOrdenCliente(request):
    if request.method == 'GET':
        nit_cliente = request.GET.get('nit_cliente')
        
        # Obtener las órdenes de producción asociadas al cliente por su nit
        ordenes_cliente = OrdenProduccion.objects.filter(nit=nit_cliente).values_list('id_orden', flat=True)
        
        # Filtrar las transacciones de orden que corresponden a las órdenes encontradas
        transacciones = TransaccionOrden.objects.filter(id_orden__in=ordenes_cliente, estado = 'por facturar')
        if transacciones.exists():
            resultados =[]
            # Devolver los datos de la transacción en formato JSON
            for transaccion in transacciones:
                resultados.append({
                    'id_orden': transaccion.id_orden.id_orden,
                    'estado': transaccion.estado,
                })
                # Devolver los datos de las transacciones encontradas en formato JSON
            return JsonResponse({'transacciones': resultados})
        else:
            return JsonResponse({'error': 'No se encontraron transacciones pendientes de facturación para este cliente.'}, status=404)
    else:
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    
    

def productos_facturar(request):
    if request.method == 'GET':
        id_orden = request.GET.get('id_orden')
        
        # Obtener los códigos de inventario desde TransaccionOrden para la id_orden dada
        transacciones = TransaccionOrden.objects.filter(id_orden=id_orden)
        
        # Lista para almacenar los datos de cada fórmula
        datos = []
        
        # Iterar sobre cada transacción encontrada
        for transaccion in transacciones:
            cod_inventario = transaccion.cod_inventario
            cantidad_transaccion = transaccion.cantidad
            
            
            # Obtener la fórmula correspondiente al cod_inventario
            try:
                formula = Transformulas.objects.get(cod_inventario=cod_inventario)
            except Transformulas.DoesNotExist:
                # Manejar el caso donde no se encontró la fórmula
                continue  # O retornar un JsonResponse con un mensaje de error
            
            # Calcular los valores para la fórmula
            subtotal_costo = 0.0
            total_costo = 0.0
            subtotal_venta = 0.0
            total_venta = 0.0
            iva_costo = 0.0
            utilidad_bruta = 0.0
            
            for i in range(1, 9):  # Iterar sobre los campos materia1 hasta materia8
                campo_materia = getattr(formula, f"materia{i}")
                if campo_materia:  # Verificar si hay un código de materia prima en el campo actual
                    # Consultar la materia prima por su código
                    materia_prima = TransMp.objects.filter(cod_inventario=campo_materia).order_by('-fecha_ingreso').first()
                    if materia_prima:
                        # Asignar el nombre y el costo unitario de la materia prima a la fórmula
                        setattr(formula, f"nombre_mp{i}", materia_prima.nombre_mp)
                        setattr(formula, f"costo_unitario{i}", materia_prima.costo_unitario)
                        cantidad = getattr(formula, f"cant_materia{i}")
                        costo_unitario = getattr(materia_prima, f"costo_unitario")
                        subtotal_costo += cantidad * costo_unitario
                    else:
                        # Asignar valores predeterminados si la materia prima no se encuentra
                        setattr(formula, f"nombre_mp{i}", "Materia prima no encontrada")
                        setattr(formula, f"costo_unitario{i}", 0.0)
            
            # Calcular otros valores necesarios para la fórmula
            iva_costo = (subtotal_costo * formula.porcentajeiva) / 100            
            total_costo = subtotal_costo + formula.costosindirectos + iva_costo
            utilidad_bruta = ((subtotal_costo + formula.costosindirectos) * formula.pocentajeutilidad) / 100
            subtotal_venta = subtotal_costo + formula.costosindirectos + utilidad_bruta
            total_venta = subtotal_venta + (subtotal_venta * formula.porcentajeiva) / 100
            
            # Redondear los valores a dos decimales
            subtotal_costo = round(subtotal_costo, 2)
            total_costo = round(total_costo, 2)
            subtotal_venta = round(subtotal_venta, 2)
            total_venta = round(total_venta, 2)
            iva_costo = round(iva_costo, 2)
            utilidad_bruta = round(utilidad_bruta, 2)
            print('cantidad producto: ', cantidad_transaccion)
            
            # Crear un diccionario con los datos de la fórmula actual
            formula_data = {
                'id_producto': formula.cod_inventario.cod_inventario,
                'nombre': formula.nombre,
                'cantidad': cantidad_transaccion,# Ajustar según tus modelos
                'iva': formula.porcentajeiva,
                #'costo_unitario': formula.costo_unitario,
                'subtotal_costo': subtotal_costo,
                'total_costo': total_costo,
                'subtotal_venta': subtotal_venta,
                'total_venta': total_venta,
                'iva_costo': iva_costo,
                'utilidad_bruta': utilidad_bruta,
            }
            
            # Agregar el diccionario a la lista de datos
            datos.append(formula_data)
        
        # Devolver los datos en formato JSON
        return JsonResponse({'datos': datos})
    else:
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    

def PFacturar(request):
    if request.method == 'POST':
        try:
            # Obtener los datos del cuerpo de la solicitud POST
            body_unicode = request.body.decode('utf-8')
            datos_facturacion = json.loads(body_unicode)

            # Procesar los datos como desees
            print('Datos desde JS:', datos_facturacion)

            # Devolver una respuesta JSON si lo deseas
            return JsonResponse({'mensaje': 'Datos recibidos correctamente'})

        except json.JSONDecodeError as e:
            # Manejar el error de decodificación JSON
            print('Error de decodificación JSON:', str(e))
            return JsonResponse({'error': 'Datos JSON inválidos'}, status=400)

    # Manejar otras solicitudes o devolver un error si es necesario
    return JsonResponse({'error': 'Método de solicitud no permitido'}, status=405)