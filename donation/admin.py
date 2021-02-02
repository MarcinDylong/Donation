from django.contrib import admin
from django.db.models.signals import pre_delete
from django.dispatch.dispatcher import receiver
from django.contrib.auth.models import User
from django.core.exceptions import PermissionDenied

from .models import Category, Institution, Donation

# Register your models here.

admin.site.register(Category)
admin.site.register(Institution)
admin.site.register(Donation)

@receiver(pre_delete, sender=User)
def delete_user(sender, instance, **kwargs):
    if instance.is_superuser:
        raise PermissionDenied