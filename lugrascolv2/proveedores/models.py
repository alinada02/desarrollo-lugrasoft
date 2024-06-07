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

class Compras(models.Model):
    id_compra = models.IntegerField(primary_key=True)
    total_factura = models.IntegerField()
    estado = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'compras'

class Proveedores(models.Model):
    id_proveedor = models.IntegerField(primary_key=True)
    nombre_proveedor = models.TextField()
    direccion = models.TextField(blank=True, null=True)
    telefono = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedores'

class TransMp(models.Model):
    nombre_mp = models.TextField()
    cant_mp = models.IntegerField()
    costo_unitario = models.FloatField()
    total_linea = models.FloatField()
    fecha_ingreso = models.DateField()
    unidad_medida = models.TextField()
    id_compra = models.ForeignKey(Compras, models.DO_NOTHING, db_column='id_compra')
    id_proveedor = models.IntegerField()
    cod_inventario = models.ForeignKey(Inventario, models.DO_NOTHING, db_column='cod_inventario')
    tipo = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'trans_mp'

