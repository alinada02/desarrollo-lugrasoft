from django.urls import path
from .views import facturar, obtenerOrdenCliente


urlpatterns = [
    path('', facturar, name= 'facturacion' ),
    path('obtenerOrden/', obtenerOrdenCliente, name='obtenerOrdenCliente'),
]