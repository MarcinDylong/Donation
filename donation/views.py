from django.shortcuts import render
from django.views import View
from django.views.generic import TemplateView
from django.db.models import Sum

from .models import Category,Institution,Donation

class IndexPage(View):
    def get(self, request):
        qty = Donation.objects.values('quantity').aggregate(Sum('quantity'))
        inst = Donation.objects.values('institution').distinct().count()
        fund = Institution.objects.filter(type='F')
        orgp = Institution.objects.filter(type='OP')
        zblk = Institution.objects.filter(type='ZL')
        ctx= {'qty': qty['quantity__sum'], 'inst': inst, 'fund': fund, 'orgp': orgp, 'zblk': zblk}
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
