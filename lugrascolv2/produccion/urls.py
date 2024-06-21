from django.urls import path
from .views import pedido, add_cliente, obtener_numero_produccion, obtener_materias_primas, crear_transaccion_orden, ver_orden_en_curso
urlpatterns = [
    path('', pedido, name= 'pedidos'),
    path('cliente/',add_cliente, name='addcliente' ),
    path('obtener_numero_produccion/', obtener_numero_produccion, name='obtener_numero_produccion'),
    path('obtener_materias_primas/', obtener_materias_primas, name= 'obtenerMateriasPrimas' ),
    path('crear_transaccion_orden/', crear_transaccion_orden, name= 'ordenProduccion'),
    path('ver_orden_en_curso/', ver_orden_en_curso, name= 'ordenCurso')
    
    
]