from django.test import TestCase, Client
from django.contrib.auth.models import User
from donation.forms import (RegisterForm, LoginForm, DonationForm,
    ChangePasswordForm, SettingForm, PasswordResetForm, SetPasswordForm,)


class RegisterFormTest(TestCase):
    def test_form_has_fields(self):
        form = RegisterForm()
        expected = ['first_name',
                    'last_name',
                    'email',
                    'password',
                    'is_superuser',
                    'rep_password',]
        actual = list(form.fields)
        self.assertSequenceEqual(expected, actual)

    def test_rep_password_is_the_same(self):
        data = {
            'first_name': 'Test',
            'last_name': 'Test',
            'email': 'test@mail.com',
            'password': 'Test123!',
            'rep_password': 'Test123'
        }
        
        form = RegisterForm(data)
        self.assertEquals(form.errors, {'__all__': ['Powtórzone hasło się nie zgadza!']})


    def test_password_validator(self):
        data = {
            'first_name': 'Test',
            'last_name': 'Test',
            'email': 'test@mail.com',
            'password': 'test',
            'rep_password': 'test'
        }
        
        form = RegisterForm(data)
        self.assertEquals(form.errors, {'__all__':
            [
                'Hasło musi posiadać przynajmniej jeden znak specjalny!',
                'Haslo musi zawierać przynajmniej jedną cyfrę!',
                'Hasło musi zawierać przynajmniej jedną dużą literę!',
                'Hasło musi zawierać przynajmniej 8 znaków!'
            ]}
        )

    def test_email_validator(self):
        data = {
            'first_name': 'Test',
            'last_name': 'Test',
            'email': 'test',
            'password': 'Test123!',
            'rep_password': 'Test123!'
        }
        form = RegisterForm(data)
        self.assertEquals(form.errors, {
            'email': ['Wprowadź poprawny adres email.'], 
            '__all__': ['Podano niepoprawny adres e-mail!']}
        )


    def test_username_taken(self):
        self.client = Client(HTTP_HOST='localhost:8000')
        User.objects.create(username='test@test.com', email='test@test.com')
        data = {
            'first_name': 'Test',
            'last_name': 'Test',
            'email': 'test@test.com',
            'password': 'Test123!',
            'rep_password': 'Test123!'
        }
        form = RegisterForm(data)
        self.assertEquals(form.errors, {
            '__all__': ['Użytkownik o takim emailu już istnieje!']}
        )


class LoginFormTest(TestCase):
    def test_form_has_fields(self):
        form = LoginForm()
        expected = ['email',
                    'password']
        actual = list(form.fields)
        self.assertSequenceEqual(expected, actual)
