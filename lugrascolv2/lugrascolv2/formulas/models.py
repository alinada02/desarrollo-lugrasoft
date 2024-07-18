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

class Transformulas(models.Model):
    nombre = models.TextField()
    materia1 = models.IntegerField(blank=True, null=True)
    cant_materia1 = models.FloatField(blank=True, null=True)
    materia2 = models.IntegerField(blank=True, null=True)
    cant_materia2 = models.FloatField(blank=True, null=True)
    materia3 = models.IntegerField(blank=True, null=True)
    cant_materia3 = models.FloatField(blank=True, null=True)
    materia4 = models.IntegerField(blank=True, null=True)
    cant_materia4 = models.FloatField(blank=True, null=True)
    materia5 = models.IntegerField(blank=True, null=True)
    cant_materia5 = models.FloatField(blank=True, null=True)
    materia6 = models.IntegerField(blank=True, null=True)
    cant_materia6 = models.FloatField(blank=True, null=True)
    materia7 = models.IntegerField(blank=True, null=True)
    cant_materia7 = models.FloatField(blank=True, null=True)
    materia8 = models.IntegerField(blank=True, null=True)
    cant_materia8 = models.FloatField(blank=True, null=True)
    cod_inventario = models.ForeignKey(Inventario, models.DO_NOTHING, db_column='cod_inventario')
    porcentajeiva = models.FloatField()
    pocentajeutilidad = models.FloatField()
    costosindirectos = models.FloatField()

    class Meta:
        managed = False
        db_table = 'transformulas'

