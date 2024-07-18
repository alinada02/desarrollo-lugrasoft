from django.db import models

# Create your models here.
class Inventario(models.Model):
    cod_inventario = models.IntegerField(primary_key=True)
    nombre = models.TextField()
    cantidad = models.IntegerField()
    id_proveedor = models.ForeignKey('Proveedores', models.DO_NOTHING, db_column='id_proveedor')
    tipo = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'inventario'

class Averias(models.Model):
    id_averia = models.IntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'Averias'


class TransaccionAjuste(models.Model):
    fecha_ajuste = models.DateField()
    cant_ajuste = models.DecimalField(max_digits=65535, decimal_places=65535)
    descripcion = models.TextField(blank=True, null=True)
    id_ajuste = models.ForeignKey('Ajustes', models.DO_NOTHING, db_column='id_ajuste')
    cod_inventario = models.ForeignKey('Inventario', models.DO_NOTHING, db_column='cod_inventario')

    class Meta:
        managed = False
        db_table = 'Transaccion_ajuste'


class TransaccionAverias(models.Model):
    cant_averia = models.DecimalField(max_digits=65535, decimal_places=65535)
    fecha_averia = models.DateField()
    id_averia = models.ForeignKey(Averias, models.DO_NOTHING, db_column='id_averia')
    cod_inventario = models.ForeignKey('Inventario', models.DO_NOTHING, db_column='cod_inventario')

    class Meta:
        managed = False
        db_table = 'Transaccion_averias'

class Ajustes(models.Model):
    id_ajuste = models.IntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'ajustes'
class Proveedores(models.Model):
    id_proveedor = models.IntegerField(primary_key=True)
    nombre_proveedor = models.TextField()
    direccion = models.TextField(blank=True, null=True)
    telefono = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedores'
