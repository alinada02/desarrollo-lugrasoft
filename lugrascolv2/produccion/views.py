from urllib import request
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from .models import Clientes, Inventario, OrdenProduccion, Transformulas, TransaccionOrden
from django.db.models import Max, F
from django.contrib.auth.models import User

# Create your views here.
def pedido(request):
    cliente = Clientes.objects.all()
    producto = Inventario.objects.filter(tipo='pt')
    usuarios = User.objects.all()
    return render(request, 'pedidos1.html', {'clientes': cliente, 'productos': producto, 'usuarios': usuarios})



def add_cliente(request):
        if request.method == 'POST':
            nit = request.POST.get('nit')
            nombre = request.POST.get('name')
            direccion = request.POST.get('direccion')
            telefono = request.POST.get('telefono')
            email = request.POST.get('email')

            # Verificar si ya existe un proveedor con el mismo NIT
            if Clientes.objects.filter(nit=nit).exists():
                # Mostrar una alerta indicando que el proveedor ya existe
                return render(request, 'orden_compra.html', {'Clientes_existente': True})

            # Crear una nueva instancia del modelo Proveedor y guardarla en la base de datos
            nuevo_Cliente = Clientes(nit=nit, nombre=nombre, direccion=direccion, telefono=telefono, email=email)
            nuevo_Cliente.save()

            # Devolver al usuario a la URL anterior
            previous_url = request.META.get('HTTP_REFERER')
            return redirect(previous_url)

def obtener_numero_produccion(request):
    ultima_averia = None  # Define la variable antes del bloque try
    
    try:
        ultima_produccion = OrdenProduccion.objects.aggregate(Max('id_orden'))['id_orden__max']
        print(ultima_averia)
        if ultima_produccion is not None:
            nueva_produccion = ultima_produccion + 1
        else:
            nueva_produccion = 40001
            print(nueva_produccion)
    except Exception as e:
        print(f"Error al obtener o generar el número de ajuste: {e}")
        nueva_produccion = None

    data = {'numero_orden': nueva_produccion, 'ultimo_produccido': ultima_produccion}
    return JsonResponse(data)



def obtener_materias_primas(request):
    producto_id = request.GET.get('producto_id')
    if producto_id:
        try:
            formula = Transformulas.objects.get(cod_inventario=producto_id)
            materias_primas = {
                'materia1': (formula.materia1, formula.cant_materia1),
                'materia2': (formula.materia2, formula.cant_materia2),
                'materia3': (formula.materia3, formula.cant_materia3),
                'materia4': (formula.materia4, formula.cant_materia4),
                'materia5': (formula.materia5, formula.cant_materia5),
                'materia6': (formula.materia6, formula.cant_materia6),
                'materia7': (formula.materia7, formula.cant_materia7),
                'materia8': (formula.materia8, formula.cant_materia8),
            }
            # Filtrar los campos vacíos y obtener nombres y cantidades del inventario
            materias_primas = {k: v for k, v in materias_primas.items() if v[0] is not None}

            detalles_materias_primas = []
            for key, (materia_id, cantidad_requerida) in materias_primas.items():
                inventario = get_object_or_404(Inventario, pk=materia_id)
                detalles_materias_primas.append({
                    'codigo': inventario.cod_inventario,
                    'nombre': inventario.nombre,
                    'cantidad_requerida': cantidad_requerida,
                    'cantidad_actual': inventario.cantidad,  # Asumiendo que hay un campo `cantidad` en Inventario
                })

            return JsonResponse({'success': True, 'materias_primas': detalles_materias_primas})
        except Transformulas.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Fórmula no encontrada'})
    return JsonResponse({'success': False, 'error': 'ID de producto no proporcionado'})




def crear_transaccion_orden(request):
    if request.method == 'POST':
        # Obtener los datos enviados desde el frontend
        datosEnviar = request.POST  # Ajusta según cómo se envían los datos desde el frontend

        # Extraer los datos específicos
        numero_factura = datosEnviar.get('numero_factura')
        fecha_actual = datosEnviar.get('fecha_actual')
        fecha_estimada_entrega = datosEnviar.get('fecha_estimada_entrega')
        prioridad = datosEnviar.get('prioridad')
        id_cliente = datosEnviar.get('id_cliente')
        detalles_productos = datosEnviar.getlist('detalles_productos[]')  # Ajusta según el nombre de tu campo de lista
        responsable = datosEnviar.get('responsable')

        try:
            # Crear la instancia de TransaccionOrden
            transaccion_orden = TransaccionOrden.objects.create(
                id_orden=numero_factura,
                fecha_creacion=fecha_actual,
                fecha_entrega=fecha_estimada_entrega,
                prioridad=prioridad,
                nit=id_cliente,
                responsable=responsable
            )

            # Agregar los detalles de productos a los campos existentes en el modelo TransaccionOrden
            for detalle in detalles_productos:
                producto_id = detalle.get('producto_id')
                cantidad = detalle.get('cantidad')

                # Aquí actualizamos los campos existentes en la instancia de TransaccionOrden
                setattr(transaccion_orden, f'producto_{producto_id}_cantidad', cantidad)
                setattr(transaccion_orden, f'producto_{producto_id}_estado', detalle.get('estado', ''))
                setattr(transaccion_orden, f'producto_{producto_id}_fecha_entrega', detalle.get('fecha_entrega', None))

            # Guardar la instancia de TransaccionOrden con los detalles de productos añadidos
            transaccion_orden.save()    
            return JsonResponse({'message': 'Transacción creada correctamente'}, status=201)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)

    return JsonResponse({'error': 'Método no permitido'}, status=405)