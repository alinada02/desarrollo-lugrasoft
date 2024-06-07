from django.contrib import admin
from .models import Inventario,Compras,Proveedores,TransMp
# Register your models here.
admin.site.register(Inventario)
admin.site.register(Compras)
admin.site.register(Proveedores)
admin.site.register(TransMp)