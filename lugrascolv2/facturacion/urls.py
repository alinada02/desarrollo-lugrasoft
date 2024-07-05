from django.urls import path
from .views import facturar, obtenerOrdenCliente, productos_facturar,PFacturar


urlpatterns = [
    path('', facturar, name= 'facturacion' ),
    path('obtenerOrden/', obtenerOrdenCliente, name='obtenerOrdenCliente'),
    path('productosAFacturar/', productos_facturar , name= 'datosFacturacion'),
    path('facturar/', PFacturar , name= 'facturacion')
]