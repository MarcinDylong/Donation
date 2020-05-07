from django.contrib.auth.models import User
from django.db import models


# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=64)

    def __str__(self):
        return self.name


Institution_type = [
    ('F', 'Fundacja'),
    ('OP', 'Organizacja pozarządowa'),
    ('ZL', 'Zbiórka lokalna'),
]


class Institution(models.Model):
    name = models.CharField(max_length=64)
    description = models.TextField()
    type = models.CharField(max_length=2, choices=Institution_type, default='Fundacja')
    categories = models.ManyToManyField(Category)

    def __str__(self):
        return f'{self.get_type_display()}: {self.name}'

    def desc(self):
        return {self.description}


class Donation(models.Model):
    quantity = models.SmallIntegerField()
    categories = models.ManyToManyField(Category)
    institution = models.ForeignKey(Institution, on_delete=models.CASCADE)
    address = models.TextField()
    phone_number = models.CharField(max_length=16)
    city = models.CharField(max_length=32)
    zip_code = models.CharField(max_length=8)
    pick_up_date = models.DateField()
    pick_up_time = models.TimeField()
    user = models.ForeignKey(User, blank=True, null=True, on_delete=models.SET_NULL)
    notes = models.TextField(blank=True, null=True)
