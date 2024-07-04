from django.http import JsonResponse
from django.shortcuts import render
from .models import Clientes
from inventario.models import Inventario
from produccion.models import OrdenProduccion

# Create your views here.
def facturar(request):
    clientes = Clientes.objects.all()
    productos = Inventario.objects.all()
    
    
    return render(request, 'facturacion.html',{'clientes': clientes , 'productos': productos})


def obtenerOrdenCliente(request):
    if request.method == 'GET':
        nit_cliente = request.GET.get('nit_cliente')
        # Filtrar las órdenes asociadas al cliente
        ordenes = OrdenProduccion.objects.filter(nit=nit_cliente).values('id', 'numero')
        # Devolver las órdenes en formato JSON
        return JsonResponse({'ordenes': list(ordenes)})
    else:
        return JsonResponse({'error': 'Método no permitido'}, status=405)