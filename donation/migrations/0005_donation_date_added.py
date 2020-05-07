# Generated by Django 3.0.5 on 2020-05-07 20:41

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('donation', '0004_donation_is_taken'),
    ]

    operations = [
        migrations.AddField(
            model_name='donation',
            name='date_added',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]
