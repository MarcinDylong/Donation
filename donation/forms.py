from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.http import request

from .models import Category, Donation, Institution


class LoginForm(forms.ModelForm):
    email = forms.CharField(label='Email', widget=forms.TextInput(attrs={'placeholder': 'Email'}))
    password = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'placeholder': 'Hasło'}))

    class Meta:
        model = User
        fields = ('email', 'password')


class RegisterForm(forms.ModelForm):
    email = forms.EmailField(label='E-mail:', widget=forms.TextInput(attrs={'placeholder': 'Email'}),
                             validators=[validate_email])

    first_name = forms.CharField(label='First name:', widget=forms.TextInput(attrs={'placeholder': 'Imię'}))
    last_name = forms.CharField(label='Last name:', widget=forms.TextInput(attrs={'placeholder': 'Nazwisko'}))
    password = forms.CharField(label='Password:', widget=forms.PasswordInput(attrs={'placeholder': 'Hasło'}))
    rep_password = forms.CharField(label='Repeat password:',
                                   widget=forms.PasswordInput(attrs={'placeholder': 'Powtórz Hasło'}))

    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'email', 'password', 'is_superuser')

    def clean(self, passwordValidation=None):
        # Automatically called by form.is_valid()
        # ...can also use 'clean_FIELDNAME()' for individual fields

        email = self.cleaned_data['email']

        if User.objects.filter(username=email).exists():
            raise ValidationError('Użytkownik o takim emailu już istnieje!')

        password = self.cleaned_data['password']
        rep_password = self.cleaned_data['rep_password']

        if password != rep_password:
            raise ValidationError('Powtórzone hasło się nie zgadza!')

        validate_password(password)


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
    notes = forms.CharField(label='Uwagi do odbioru',
                            widget=forms.TextInput(attrs={"name": "more_info", "rows": "5"}))

    class Meta:
        model = Donation
        exclude = ('user',)
