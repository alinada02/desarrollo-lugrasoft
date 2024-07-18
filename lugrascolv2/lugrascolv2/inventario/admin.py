from django.contrib import admin
from .models import Inventario, Averias, TransaccionAjuste,TransaccionAverias, Ajustes, Proveedores

# Register your models here.
admin.site.register(Inventario)
admin.site.register(Averias)
admin.site.register(TransaccionAjuste)
admin.site.register(TransaccionAverias)
admin.site.register(Ajustes)
admin.site.register(Proveedores)