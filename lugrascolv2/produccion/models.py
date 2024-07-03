from django.db import models

# Create your models here.

class Clientes(models.Model):
    nit = models.DecimalField(db_column='Nit', primary_key=True, max_digits=65535, decimal_places=65535)  # Field name made lowercase.
    nombre = models.TextField()
    direccion = models.TextField()
    telefono = models.DecimalField(max_digits=65535, decimal_places=65535)
    email = models.TextField()

    class Meta:
        managed = False
        db_table = 'Clientes'


class OrdenProduccion(models.Model):
    id_orden = models.IntegerField(primary_key=True)
    nit = models.ForeignKey(Clientes, models.DO_NOTHING, db_column='Nit')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Orden_produccion'

class Inventario(models.Model):
    cod_inventario = models.IntegerField(primary_key=True)
    nombre = models.TextField()
    cantidad = models.IntegerField()
    id_proveedor = models.ForeignKey('Proveedores', models.DO_NOTHING, db_column='id_proveedor')
    tipo = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'inventario'


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

class Proveedores(models.Model):
    id_proveedor = models.IntegerField(primary_key=True)
    nombre_proveedor = models.TextField()
    direccion = models.TextField(blank=True, null=True)
    telefono = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedores'

class TransaccionOrden(models.Model):
    fecha_entrega = models.DateField(db_column='fecha_Entrega')  # Field name made lowercase.
    estado = models.TextField()
    cod_inventario = models.ForeignKey('Inventario', models.DO_NOTHING, db_column='cod_inventario')
    cantidad = models.IntegerField()
    id_orden = models.ForeignKey(OrdenProduccion, models.DO_NOTHING, db_column='id_orden')
    prioridad = models.TextField()
    fecha_creacion = models.DateField()
    responsable = models.TextField()
    fecha_terminacion_orden = models.DateField(blank=True, null=True)
    

    class Meta:
        managed = False
        db_table = 'Transaccion_orden'

class SalidasMpOrden(models.Model):
    cod_inventario = models.ForeignKey('Inventario', models.DO_NOTHING, db_column='cod_inventario')
    cantidad = models.IntegerField()
    id_orden = models.ForeignKey(OrdenProduccion, models.DO_NOTHING, db_column='id_orden')
    fecha_e_produccion = models.DateField(db_column='fecha_E_produccion', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Salidas_Mp_Orden'