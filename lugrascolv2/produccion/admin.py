from django.contrib import admin
from .models import Clientes,OrdenProduccion,Inventario,Transformulas,Proveedores
# Register your models here.
admin.site.register(Proveedores)
admin.site.register(Clientes)
admin.site.register(OrdenProduccion)
admin.site.register(Inventario)
admin.site.register(Transformulas)