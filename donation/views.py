from itertools import count

from django.shortcuts import render
from django.views import View
from django.views.generic import TemplateView
from django.db.models import Sum

from .models import Category,Institution,Donation

class IndexPage(View):
    def get(self, request):
        bags = Donation.objects.values('quantity').aggregate(Sum('quantity'))
        inst_qty = Donation.objects.values('institution').distinct().count()
        ctx= {'qty': bags['quantity__sum'], 'inst': inst_qty}
        return render(request, 'index.html', ctx)

# class IndexPage(TemplateView):
#     template_name = 'index.html'

class AddDonation(View):
    def get(self, request):
        return render(request, 'form.html')

class Login(View):
    def get(self, request):
        return render(request, 'login.html')

class Register(View):
    def get(self, request):
        return render(request, 'register.html')