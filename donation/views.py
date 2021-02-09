from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordResetForm
from django.core.paginator import Paginator
from django.core.mail import send_mail
from django.db.models import Sum
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.views import View


from .forms import LoginForm, RegisterForm, DonationForm, ChangePasswordForm, SettingForm
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
    def change_don(self, id):
        don_chan = Donation.objects.get(pk=id)
        if don_chan.is_taken:
            don_chan.is_taken = False
            don_chan.save()
        else:
            don_chan.is_taken = True
            don_chan.save()

    def get(self, request):
        user = request.user
        user_id = User.objects.get(pk=user.id)
        don = Donation.objects.filter(user=user).order_by('is_taken', 'pick_up_date', 'date_added')
        ctx = {'user': user_id, 'don': don}
        return render(request, 'user-profile.html', ctx)

    def post(self, request):
        user = request.user
        usr = User.objects.get(pk=user.id)
        don_id = request.POST.get('pick_up')
        self.change_don(don_id)
        don = Donation.objects.filter(user=user).order_by('is_taken', 'pick_up_date', 'date_added')
        ctx = {'user': usr, 'don': don}
        return render(request, 'user-profile.html', ctx)


class Settings(View):
    def get(self, request):
        user = request.user
        usr = User.objects.get(pk=user.id)
        cp_form = ChangePasswordForm(initial={'user_id': user.id})
        st_form = SettingForm(
            initial={'email': usr.email, 'first_name': usr.first_name, 'last_name': usr.last_name, 'user_id': user.id})
        ctx = {'user': usr, 'cp_form': cp_form, 'st_form': st_form}
        return render(request, 'user-settings.html', ctx)

    def post(self, request):
        user = request.user
        usr = User.objects.get(pk=user.id)

        if 'st_btn' in request.POST:
            st_form = SettingForm(request.POST)
            if st_form.is_valid():
                usr.first_name = st_form.cleaned_data['first_name']
                usr.last_name = st_form.cleaned_data['last_name']
                new_mail = st_form.cleaned_data['email']
                if (usr.email != new_mail):
                    if (User.objects.filter(email=new_mail).exists()):
                        messages.error(request, 'Użytkownik o takim mailu już istnieje!')
                        return render(request, 'user-settings.html', {'st_form': st_form,
                                                                      'cp_form': ChangePasswordForm(
                                                                          initial={'user_id': user.id})})
                    else:
                        usr.email = st_form.cleaned_data['email']
                        usr.username = st_form.cleaned_data['email']
                usr.save()
                return redirect('/user_profile/')
        elif 'cp_btn' in request.POST:
            cp_form = ChangePasswordForm(request.POST)
            if cp_form.is_valid():
                usr.set_password(cp_form.cleaned_data['new_password'])
                usr.save()
                return redirect('/login/')
            else:
                messages.error(request, 'Błąd')
                return render(request, 'user-settings.html', {'st_form': SettingForm(
                    initial={'email': usr.email, 'first_name': usr.first_name, 'last_name': usr.last_name,
                             'user_id': user.id}),
                                                              'cp_form': cp_form})
        else:
            redirect('/settings/')


class DonationDetails(View):
    def get(self, request, id):
        user = request.user
        don = Donation.objects.filter(pk=id)
        if don[0].user_id != user.id:
            return redirect('/')
        ctx = {'don': don}
        return render(request, 'donation-details.html', ctx)

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
            return redirect('/login')
        else:
            ctx = {'form': form}
            return render(request, 'register.html', ctx)


class ResetPasswordView(View):
    def get(self, request):
        form = PasswordResetForm()
        ctx = {'form': form}
        return render(request, 'reset_password.html', ctx)


def SendContact(request):
    if request.method == 'GET':
        name = request.GET['name']
        surname = request.GET['surname']
        email = request.GET['email']
        message = request.GET['message']
        topic = f'Message from {name} {surname}, Donation contact form.'
        ctx = {'name': name, 'surname': surname,
               'email': email, 'message': message}
        try:
            send_mail(topic, message, email, ['donation@mail.com'])
            ctx = {'info': 'Twój mail został wysłany'}
        except:
            ctx = {'info': 'Wystąpił błąd'}
        return render(request, 'message_sent.html', ctx)
