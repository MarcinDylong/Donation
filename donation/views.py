from django.contrib.auth.models import User
from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.views import View
from django.views.generic import TemplateView
from django.db.models import Sum
from django.contrib import messages
from braces.views import CsrfExemptMixin

from .models import Category,Institution,Donation

class IndexPage(View):
    def get(self, request):
        ## Liczniki
        qty = Donation.objects.values('quantity').aggregate(Sum('quantity'))
        inst = Donation.objects.values('institution').distinct().count()
        ## Fundację
        fund = Institution.objects.filter(type='F')
        paginator_f = Paginator(fund,2)
        page_f = request.GET.get('page_f')
        fund = paginator_f.get_page(page_f)
        ## Organizacje pozarządowe
        orgp = Institution.objects.filter(type='OP')
        paginator_o = Paginator(orgp, 2)
        page_o = request.GET.get('page_o')
        orgp = paginator_o.get_page(page_o)
        ## Zbiórki lokalne
        zblk = Institution.objects.filter(type='ZL')
        paginator_z = Paginator(zblk, 2)
        page_z = request.GET.get('page_z')
        zblk = paginator_z.get_page(page_z)
        ## Context
        ctx= {'qty': qty['quantity__sum'], 'inst': inst, 'fund': fund, 'orgp': orgp, 'zblk': zblk}
        return render(request, 'index.html', ctx)

# class IndexPage(TemplateView):
#     template_name = 'index.html'

class AddDonation(View):
    def get(self, request):
        return render(request, 'form.html')

class Login(CsrfExemptMixin, View):
    def get(self, request):
        return render(request, 'login.html')

class Register(CsrfExemptMixin, View):
    def password_valid(self, passwd):
        errors = []
        if len(passwd) < 8:
            errors.append('Hasło musi mieć przynajmniej 8 znaków!')

        if not any(char.isdigit() for char in passwd):
            errors.append('Hasło musi zawierać przynajmniej jedną cyfrę!')

        if not any(char.isupper() for char in passwd):
            errors.append('Hasło musi zawierać przynajmniej jedną dużą literę!')

        if not any(char.islower() for char in passwd):
            errors.append('Hasło musi zawierać przynajmniej jedną małą literę!')

        return errors

    def get(self, request):
        return render(request, 'register.html')

    def post(self, request):
        name = request.POST.get('name')
        surname = request.POST.get('surname')
        email = request.POST.get('email')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')

        errors = self.password_valid(password)
        if errors:
            for e in errors:
                messages.error(request, e)
            return render(request, 'register.html')

        if password != password2:
            messages.error(request,'Powtórzone hasło nie zgadza się!')
            return render(request, 'register.html')

        if User.objects.filter(email=email).exists():
            messages.error(request, 'Użytkownik o takim e-mailu już istnieje')
            return render(request, 'register.html')



        User.objects.create_user(first_name=name, last_name=surname, username=email, email=email, password=password)
        return render(request, 'login.html')

