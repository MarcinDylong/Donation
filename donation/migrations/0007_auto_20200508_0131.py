# Generated by Django 3.0.5 on 2020-05-07 23:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('donation', '0006_donation_date_update'),
    ]

    operations = [
        migrations.AlterField(
            model_name='donation',
            name='date_update',
            field=models.DateTimeField(auto_now=True),
        ),
    ]
