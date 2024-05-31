from django.urls import path
from .views import InicioSesion, Validar_Credenciales, Dashboard, exit

urlpatterns = [
    path('', InicioSesion, name= 'inicio'),
    path('validado/', Validar_Credenciales, name= 'validar'),
    path('dash/', Dashboard, name='dashboard' ),
    path('exit', exit , name= 'exit')
]