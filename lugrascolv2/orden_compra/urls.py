from django.urls import path
from .views import  orden, agregar_cantidades_precio, obtener_productos, mostrar_datos, compras,verOrden,actualizar_inventario_orden, actualizar_inventario, actualizar_estado_compra, agregar_proveedor,guardar_producto, edita_orden_compra, obtener
urlpatterns = [
    path('', orden, name= 'orden'),
    path('nueva', agregar_cantidades_precio , name='nueva_orden'),
    path('obtener/', obtener_productos, name='obtener'),
    path('mostrar-datos/', mostrar_datos, name='mostrar_datos'),
    path('compras', compras, name= 'compras'),
    path('ver/<int:id_compra>/', verOrden, name= 'verOrden'),
    path('actualizar', actualizar_inventario_orden, name= 'actualizar'),
    path('act-inventario/<int:id_compra>/', actualizar_inventario , name= 'actualizar-inventario'),
    path('act-estado/<int:id_compra>/', actualizar_estado_compra , name= 'actualizar-estado'),
    path('addproveedor/',agregar_proveedor , name= 'addprov'),
    path('guardar/', guardar_producto, name= 'guardar'),
    path('editar/<int:numero_compra>/', edita_orden_compra , name='editar'),
    path('cargar', obtener, name = 'cargar'),
    
    
    
]