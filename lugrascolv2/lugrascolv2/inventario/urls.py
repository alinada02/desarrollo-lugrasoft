from django.urls import path
from .views import inventory_view, ajuste, obtener_numero_ajuste,agregar_transaccion_ajuste, agregar_transaccion_averias,obtener_numero_averia,averias, generar_informe_averia
urlpatterns = [
    path('', inventory_view, name= 'inv'),
    path('ajuste/', ajuste , name= 'ajuste'),
    path('obtener/', obtener_numero_ajuste, name= 'obtenerA'),
    path('agregar/', agregar_transaccion_ajuste, name= 'agregar_transaccion'),
    path('averias/', averias, name= 'averias'),
    path('obtener_averiaN/', obtener_numero_averia, name= 'obtenerAveria'),
    path('agregarAveria/', agregar_transaccion_averias, name='agregarAverias'),
    path('informe/', generar_informe_averia, name= 'informe')
]