from django import forms
from django.http import request
from django.template import loader
from django.core.mail import EmailMultiAlternatives
from django.utils.encoding import force_bytes
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.utils.http import urlsafe_base64_encode
from django.contrib.sites.shortcuts import get_current_site
from django.contrib.auth.tokens import default_token_generator

from .models import Category, Donation, Institution



def password_validator(password, rep_password):

    special_characters = "[~\!@#\$%\^&\*\(\)_\+{}\":;'\[\]]"
    errors = []

    if not any(char in special_characters for char in password):
        errors.append(ValidationError(
            'Hasło musi posiadać przynajmniej jeden znak specjalny!'))
    if not any(char.isdigit() for char in password):
        errors.append(ValidationError(
            'Haslo musi zawierać przynajmniej jedną cyfrę!'))
    if not any(char.isupper() for char in password):
        errors.append(ValidationError(
            'Hasło musi zawierać przynajmniej jedną dużą literę!'))
    if not any(char.islower() for char in password):
        errors.append(ValidationError(
            'Hasło musi zawierać przynajmniej jedną małą literę!'))
    if len(password) < 8:
        errors.append(ValidationError(
            'Hasło musi zawierać przynajmniej 8 znaków!'))

    if password != rep_password:
        errors.append(ValidationError('Powtórzone hasło się nie zgadza!'))

    if errors:
        raise ValidationError(errors)


class LoginForm(forms.ModelForm):
    email = forms.CharField(label='Email', widget=forms.TextInput(attrs={'placeholder': 'Email'}))
    password = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'placeholder': 'Hasło'}))

    class Meta:
        model = User
        fields = ('email', 'password')



class RegisterForm(forms.ModelForm):
    email = forms.EmailField(label='E-mail:', widget=forms.TextInput(attrs={'placeholder': 'Email'}))
    first_name = forms.CharField(label='First name:', widget=forms.TextInput(attrs={'placeholder': 'Imię'}))
    last_name = forms.CharField(label='Last name:', widget=forms.TextInput(attrs={'placeholder': 'Nazwisko'}))
    password = forms.CharField(label='Password:', widget=forms.PasswordInput(attrs={'placeholder': 'Hasło'}))
    rep_password = forms.CharField(label='Repeat password:',
                                   widget=forms.PasswordInput(attrs={'placeholder': 'Powtórz Hasło'}))

    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'email', 'password', 'is_superuser')

    def clean(self):
        # Automatically called by form.is_valid()
        # ...can also use 'clean_FIELDNAME()' for individual fields

        ## Walidacja maila
        try:
            email = self.cleaned_data['email']
        except:
            raise ValidationError('Podano niepoprawny adres e-mail!')

        if User.objects.filter(username=email).exists():
            raise ValidationError('Użytkownik o takim emailu już istnieje!')
        

        ## Walidacja hasła
        password = self.cleaned_data['password']
        rep_password = self.cleaned_data['rep_password']
        password_validator(password, rep_password)


class DonationForm(forms.ModelForm):
    categories = forms.ModelMultipleChoiceField(label='Kategorie',
                                                queryset=Category.objects.all().order_by('name'),
                                                widget=forms.SelectMultiple())
    quantity = forms.IntegerField(label='Ilość worków',
                                  widget=forms.NumberInput(attrs={'placeholder': 'Liczba 60l worków:',
                                                                  "type": "number", "name": "bags",
                                                                  "step": "1", "min": "1"}))
    institution = forms.ModelChoiceField(label='Instytucje',
                                         queryset=Institution.objects.all().order_by('name'),
                                         widget=forms.Select())
    address = forms.CharField(label='Adres', widget=forms.TextInput(attrs={"type": "text", "name": "address"}))
    phone_number = forms.CharField(label='Numer telefonu', max_length=16,
                                   widget=forms.TextInput(attrs={"type": "phone", "name": "phone"}))
    city = forms.CharField(label='Miasto', max_length=32,
                           widget=forms.TextInput(attrs={"type": "text", "name": "city"}))
    zip_code = forms.CharField(label='Kod pocztowy', max_length=8,
                               widget=forms.TextInput(attrs={"type": "text", "name": "postcode"}))
    pick_up_date = forms.DateField(label='Data odbioru', widget=forms.DateInput(attrs={"type": "date", "name": "data"}))
    pick_up_time = forms.TimeField(label='Godzina odbioru',
                                   widget=forms.TimeInput(attrs={"type": "time", "name": "time"}))
    notes = forms.CharField(label='Uwagi do odbioru', required=False,
                            widget=forms.TextInput(attrs={"name": "more_info", "rows": "5"}))

    class Meta:
        model = Donation
        exclude = ('user',)


class ChangePasswordForm(forms.Form):
    user_id = forms.IntegerField(widget=forms.HiddenInput)
    old_password = forms.CharField(label='Old password', widget=forms.PasswordInput(attrs={'placeholder': 'Stare hasło'}))
    new_password = forms.CharField(label='New password', widget=forms.PasswordInput(attrs={'placeholder': 'Nowe hasło'}))
    rep_password = forms.CharField(label='Repeat new password',
                                   widget=forms.PasswordInput(attrs={'placeholder': 'Powtórz hasło'}))

    # class Meta:
    #     model = User
    #     fields = ('password','id')

    def clean(self):
        user_id = self.cleaned_data['user_id']
        old_password = self.cleaned_data['old_password']
        new_password = self.cleaned_data['new_password']
        rep_password = self.cleaned_data['rep_password']

        user = User.objects.get(pk=user_id)

        if user is None:
            raise forms.ValidationError('Użytkownik nie istnieje')

        if not authenticate(username=user.username, password=old_password):
            raise forms.ValidationError('Nie poprawne stare hasło')

        password_validator(new_password, rep_password)


class SettingForm(forms.Form):

    email = forms.EmailField(label='E-mail:', required=False, widget=forms.TextInput(attrs={'placeholder': 'Email'}),
                             validators=[validate_email])
    first_name = forms.CharField(label='First name:', required= False,
                                 widget=forms.TextInput(attrs={'placeholder': 'Imię'}))
    last_name = forms.CharField(label='Last name:', required=False,
                                widget=forms.TextInput(attrs={'placeholder': 'Nazwisko'}))
    password = forms.CharField(label='Password',
                                   widget=forms.PasswordInput(attrs={'placeholder': 'Potwierdź hasłem'}))
    user_id = forms.IntegerField(widget=forms.HiddenInput)

    def clean(self):
        user_id = self.cleaned_data['user_id']
        password = self.cleaned_data['password']

        user = User.objects.get(pk=user_id)
        if not authenticate(username=user.username, password=password):
            raise forms.ValidationError('Nie poprawne hasło')



class PasswordResetForm(forms.Form):
    email = forms.EmailField(label='E-mail:', required=True,
                             widget=forms.TextInput(
                                 attrs={'placeholder': 'Podaj swój email'}),
                             validators=[validate_email])


    def clean(self):
        try:
            email = self.cleaned_data['email']
        except:
            raise ValidationError('Podano nie poprawny adres e-mail!')

        if not User.objects.filter(username=email).exists():
            raise ValidationError(f'Adres {email} nie znajduję się w bazie danych')


class SetPasswordForm(forms.Form):
    """
    A form that lets a user change set their password without entering the old
    password
    """
    new_password1 = forms.CharField(label="Nowe Hasło",
                                    widget=forms.PasswordInput(attrs={
                                        'placeholder': 'Nowe hasło'}))
    new_password2 = forms.CharField(label="Potwierdź nowe hasło",
                                    widget=forms.PasswordInput(attrs={
                                        'placeholder': 'Potwierdź nowe hasło'}))
    
    def __init__(self, user, *args, **kwargs):
        self.user = user
        super(SetPasswordForm, self).__init__(*args, **kwargs)

    def clean(self):
        password1 = self.cleaned_data.get('new_password1')
        password2 = self.cleaned_data.get('new_password2')

        password_validator(password1, password2)

    def save(self, commit=True):
        self.user.set_password(self.cleaned_data['new_password1'])
        if commit:
            self.user.save()
        return self.user