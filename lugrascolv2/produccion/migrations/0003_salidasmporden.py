# Generated by Django 5.0.4 on 2024-06-28 23:05

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('produccion', '0002_transaccionorden'),
    ]

    operations = [
        migrations.CreateModel(
            name='SalidasMpOrden',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.IntegerField()),
                ('fecha_salida', models.DateField()),
                ('cod_inventario', models.ForeignKey(db_column='cod_inventario', on_delete=django.db.models.deletion.DO_NOTHING, to='produccion.inventario')),
            ],
        ),
    ]
