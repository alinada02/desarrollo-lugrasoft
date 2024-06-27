import json
from urllib import request
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render


from .models import Clientes, Inventario, OrdenProduccion, Transformulas, TransaccionOrden
from django.db.models import Max, F
from django.contrib.auth.models import User
from django.db import transaction
from django.db.models import Case, When, IntegerField, Value, CharField,Min
from .models import TransaccionOrden

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


@transaction.atomic
def crear_transaccion_orden(request):
    if request.method == 'POST':
        # Obtener los datos enviados desde el frontend en formato JSON
        try:
            datosEnviar = json.loads(request.body.decode('utf-8'))
            
            # Extraer los datos específicos del objeto JSON principal
            numero_factura = datosEnviar.get('numero_factura')
            fecha_actual = datosEnviar.get('fecha_actual')
            fecha_estimada_entrega = datosEnviar.get('fecha_estimada_entrega')
            id_cliente = datosEnviar.get('id_cliente')
            responsable = datosEnviar.get('responsable')
            prioridad = datosEnviar.get('prioridad')
            detallesProductos = datosEnviar.get('detallesProductos')
            
            # Obtener el cliente
            cliente = get_object_or_404(Clientes, nit=id_cliente)
            
            # Buscar o crear la instancia de OrdenProduccion
            orden_produccion, creado = OrdenProduccion.objects.get_or_create(
                id_orden=numero_factura,
                nit=cliente
            )
            
            # Iterar sobre los detalles de productos
            for detalle in detallesProductos:
                producto_id = detalle.get('producto_id')
                cantidad = detalle.get('cantidad')
                
                # Obtener el inventario
                inventario = get_object_or_404(Inventario, pk=producto_id)
                
                # Crear la transacción de orden
                nueva_transaccion_orden = TransaccionOrden.objects.create(
                    fecha_entrega=fecha_estimada_entrega,
                    estado='creado',
                    cod_inventario=inventario,
                    cantidad=cantidad,
                    id_orden=orden_produccion,
                    prioridad=prioridad,
                    fecha_creacion=fecha_actual,
                    responsable=responsable,
                )
                nueva_transaccion_orden.save()
            
            return JsonResponse({'message': 'Transacción creada correctamente'}, status=201)
        
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)
    
    return JsonResponse({'error': 'Método no permitido'}, status=405)

# vistas para manejar la ventana orden de pedidos en curso
def ver_orden_en_curso(request):
        subquery = TransaccionOrden.objects.values('id_orden').annotate(
        min_fecha_entrega=Min('fecha_entrega')
        )
    
        transacciones = TransaccionOrden.objects.filter(
            id__in=subquery.values('id'),
        ).annotate(
            prioridad_order=Case(
                When(prioridad='urgente', then=Value(1)),
                When(prioridad='menos urgente', then=Value(2)),
                default=Value(3),
                output_field=CharField(),
            )
        ).order_by(
            'prioridad_order', 'id_orden', 'fecha_entrega'
        ).distinct('prioridad_order', 'id_orden', 'fecha_entrega')

        context = {
            'transacciones': transacciones,
        }
        return render(request, 'orden_en_curso.html', context)




def detalles_orden(request, id_orden):
    try:
        detalles = TransaccionOrden.objects.filter(id_orden = id_orden)

        
        detalle_list = []
        for detalle in detalles:
            cod_inventario = detalle.cod_inventario.cod_inventario if detalle.cod_inventario else None 
            
            if cod_inventario:
                # Consultar el nombre correspondiente al cod_inventario en el modelo Inventario
                inventario_obj = Inventario.objects.filter(cod_inventario=cod_inventario).first()
                if inventario_obj:
                    nombre_inventario = inventario_obj.nombre
            
            detalle_data = {
                'cod_inventario': cod_inventario,
                'nombre':nombre_inventario,
                'cantidad': detalle.cantidad,
                'fecha_entrega': detalle.fecha_entrega,
                'prioridad': detalle.prioridad,
                'responsable': detalle.responsable,
            }
            detalle_list.append(detalle_data)
            # Devolver los datos como una respuesta JSON
        return JsonResponse({'detalles': detalle_list})

    except Exception as e:
        # Manejar cualquier error y devolver una respuesta de error
        return JsonResponse({'error': str(e)}, status=500)