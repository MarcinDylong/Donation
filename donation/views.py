from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.core.paginator import Paginator
from django.db.models import Sum
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.views import View

from .forms import LoginForm, RegisterForm, DonationForm
from .models import Category, Institution, Donation


class IndexPage(View):
    def get(self, request):
        ## Liczniki
        qty = Donation.objects.values('quantity').aggregate(Sum('quantity'))
        inst = Donation.objects.values('institution').distinct().count()
        ## Fundację
        fund = Institution.objects.filter(type='F')
        paginator_f = Paginator(fund, 2)
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
        ctx = {'qty': qty['quantity__sum'], 'inst': inst, 'fund': fund, 'orgp': orgp, 'zblk': zblk}
        return render(request, 'index.html', ctx)


@login_required(login_url='/login/')
def AddDonation(request):
    if request.method == 'GET':
        ctx = {'form': DonationForm, 'inst': Institution.objects.all()}
        return render(request, 'form.html', ctx)

    if request.method == 'POST':
        form = DonationForm(request.POST)
        if form.is_valid():
            try:
                don = form.save()
                don.user = request.user
                don.save()
            except Exception as e:
                messages.error(request, f'Błąd: {e}')
                return render(request, 'error.html')
            return render(request, 'form-confirmation.html')
        else:
            messages.error(request, f'Błąd: {form._errors}')
            return render(request, 'error.html')

class UserProfile(View):
    def get(self, request):
        user = request.user
        user_id = User.objects.get(pk=user.id)
        don = Donation.objects.filter(user=user).order_by('pick_up_date')
        ctx = {'user': user_id, 'don': don}
        return render(request, 'user-profile.html', ctx)

class Login(View):
    def get(self, request):
        form = LoginForm()
        ctx = {'form': form}
        return render(request, 'login.html', ctx)

    def post(self, request):
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            passwd = form.cleaned_data['password']
            user = authenticate(request, username=email, password=passwd)
            if user is not None:
                login(request, user)
                return redirect('/')
            elif User.objects.filter(username=email).exists():
                messages.error(request, f'Podano nie poprawne hasło!')
                return render(request, 'login.html', {'form': form})
            else:
                messages.error(request, f'Użytkownik {email} nie istnieje, czy chcesz się zarejestrować?')
                request.session['email'] = email
                ctx = {'form': RegisterForm()}
                # return render(request, 'register.html', ctx)
                return redirect('/register/')


def Logout(request):
    logout(request)
    return redirect('/')


class Register(View):
    def get(self, request):
        form = RegisterForm()
        ctx = {'form': form}
        return render(request, 'register.html', ctx)

    def post(self, request):
        form = RegisterForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            password = form.cleaned_data['password']
            User.objects.create_user(first_name=first_name, last_name=last_name, username=email, email=email,
                                     password=password)
            return redirect('login.html')
        else:
            ctx = {'form': form}
            return render(request, 'register.html', ctx)
