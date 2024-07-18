from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout


def InicioSesion(request):
    return render(request, 'inicio.html')
# Create your views here.


def Validar_Credenciales(request):
    
    return redirect('/dash/')


@login_required    
def Dashboard(request):
    return render(request, 'dashboard.html')


def exit(request):
    logout(request)
    return redirect('inicio')
