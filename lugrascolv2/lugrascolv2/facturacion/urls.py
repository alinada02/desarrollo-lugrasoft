from django.urls import path
from .views import facturar, obtenerOrdenCliente, productos_facturar,PFacturar, obtener_numero_factura, precio_producto


urlpatterns = [
    path('', facturar, name= 'facturacion' ),
    path('obtenerOrden/', obtenerOrdenCliente, name='obtenerOrdenCliente'),
    path('productosAFacturar/', productos_facturar , name= 'datosFacturacion'),
    path('facturar/', PFacturar , name= 'facturacion'),
    path('obtenerF/', obtener_numero_factura, name= 'obtenerFactura'),
    path('precioProducto/', precio_producto, name='precioxproducto')
]