from urllib import request
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from .models import Clientes, Inventario, OrdenProduccion, Transformulas
from django.db.models import Max, F

# Create your views here.
def pedido(request):
    cliente = Clientes.objects.all()
    producto = Inventario.objects.filter(tipo='pt')
    return render(request, 'pedidos.html', {'clientes': cliente, 'productos': producto})



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