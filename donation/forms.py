from django import forms
from django.contrib.auth.models import User


class LoginForm(forms.ModelForm):
    email = forms.CharField(label='Email', widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))