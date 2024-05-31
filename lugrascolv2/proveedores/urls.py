from django.urls import path
from .views import verProveedor, obtener_productos_por_proveedor

urlpatterns = [
    path('', verProveedor, name= 'ver-proveedor'),
    path('obtener/<int:proveedor_id>/', obtener_productos_por_proveedor, name= 'obtener_productos' )
]