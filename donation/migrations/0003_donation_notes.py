# Generated by Django 3.0.5 on 2020-05-07 11:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('donation', '0002_auto_20200428_2247'),
    ]

    operations = [
        migrations.AddField(
            model_name='donation',
            name='notes',
            field=models.TextField(blank=True, null=True),
        ),
    ]