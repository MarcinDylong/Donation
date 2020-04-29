from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError


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
    rep_password = forms.CharField(label='Repeat password:',widget=forms.PasswordInput(attrs={'placeholder': 'Powtórz Hasło'}))


    class Meta:
        model = User
        fields = ('first_name','last_name','email','password')

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