from django.urls import reverse, resolve
from django.test import TestCase
from django.contrib.auth.models import User

from donation.forms import RegisterForm
from donation.views import (AddDonation, DonationDetails, IndexPage, Login, Logout,
                    Register, SendContact, Settings, UserProfile, ResetPassword,
                    ResetPasswordDone, ResetPasswordComplete,
                    ResetPasswordConfirm, AccountActivation)


class IndexTests(TestCase):
    def test_index_view_status_code(self):
        url = reverse('index')
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    def test_index_url_resolves_index(self):
        view = resolve('/')
        self.assertEquals(view.func.view_class, IndexPage)


class RegisterTest(TestCase):
    def setUp(self):
        url = reverse('register')
        self.response = self.client.get(url)

    def test_register_status_code(self):
        self.assertEquals(self.response.status_code, 200)

    def test_register_url_resolve(self):
        view = resolve('/register/')
        self.assertEquals(view.func.view_class, Register)

    def test_csrf(self):
        self.assertContains(self.response, 'csrfmiddlewaretoken')

    def test_contains_form(self):
        form = self.response.context.get('form')
        self.assertIsInstance(form, RegisterForm)

    def test_form_inputs(self):
        '''
        The view must contain five inputs: csrf, username, email,
        password1, password2
        '''
        # print(self.response.content)
        self.assertContains(self.response, '<input', 8)
        self.assertContains(self.response, 'type="text"', 5)
        self.assertContains(self.response, 'type="password"', 2)


class SuccesfulRegisterTest(TestCase):
    def setUp(self):
        url = reverse('register')
        data = {
            'first_name': 'Test',
            'last_name': 'Test',
            'email': 'test@mail.com',
            'password': 'Abcd123!',
            'rep_password': 'Abcd123!'
        }
        self.response = self.client.post(url, data)
        self.login_url = reverse('login')

    def test_redirection(self):
        '''
        A valid submission should redirect the user to the login page
        '''
        self.assertRedirects(self.response, self.login_url)
    
    def test_user_creation(self):
        self.assertTrue(User.objects.exists())

    def test_user_authentication(self):
        '''
        After registration User need to aactivate his account
        '''
        response = self.client.get(self.login_url)
        user = response.context.get('user')
        self.assertFalse(user.is_authenticated)

class InvalidSignUpTests(TestCase):
    def setUp(self):
        url = reverse('register')
        self.response = self.client.post(url, {})  # submit an empty dictionary

    def test_signup_status_code(self):
        '''
        An invalid form submission should return to the same page
        '''
        self.assertEquals(self.response.status_code, 200)

    def test_form_errors(self):
        form = self.response.context.get('form')
        self.assertTrue(form.errors)

    def test_dont_create_user(self):
        self.assertFalse(User.objects.exists())