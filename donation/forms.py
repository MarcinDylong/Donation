from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError

from .models import Category, Donation, Institution


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
        fields = ('first_name', 'last_name', 'email', 'password')

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
                                                widget=forms.Select())
    quantity = forms.IntegerField(label='Ilość worków',
                                  widget=forms.NumberInput(attrs={'placeholder': 'Liczba 60l worków:'}))
    institution = forms.ModelMultipleChoiceField(label='Instytucje',
                                                queryset=Institution.objects.all().order_by('name'),
                                                widget=forms.Select())
    address = forms.CharField(label='Adres',widget=forms.Textarea(attrs={'placeholer':'Adres',
                                                                         'rows': 1, 'cols': 40,
                                                                         'style': 'height: 1em;'}))
    phone_number = forms.CharField(label='Numer telefonu', max_length= 16,
                                   widget=forms.TextInput(attrs={'placeholder':'Numer telefonu'}))
    city = forms.CharField(label='Miasto', max_length=32,
                           widget=forms.TextInput(attrs={'placeholder':'Miasto'}))
    zip_code = forms.CharField(label='Kod pocztowy', max_length=8,
                               widget=forms.TextInput(attrs={'placeholder':'Kod pocztowy'}))
    pick_up_date = forms.DateField(label='Data odbioru', widget=forms.DateInput(attrs={'placeholder':'Data odbioru'}))
    pick_up_time = forms.TimeField(label='Godzina odbioru',
                                   widget=forms.TimeInput(attrs={'placeholder':'Godzina odbioru'}))
    notes = forms.CharField(label='Uwagi do odbioru',
                            widget=forms.Textarea(attrs={'placeholder':'Uwagi do odbioru',
                                                         'row': 4, 'column':40,
                                                         'style': 'height: 1em;'}))

    class Meta:
        model = Donation
        exclude = ('user',)
