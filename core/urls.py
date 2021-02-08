"""charity URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path

from donation.views import IndexPage, AddDonation, Login, Register, Logout, UserProfile, DonationDetails, Settings, \
                           SendContact


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', IndexPage.as_view(), name="index"),
    path('add_donation/', AddDonation, name="add_donation"),
    path('login/', Login.as_view(), name="login"),
    path('register/', Register.as_view(), name="register"),
    path('logout/', Logout, name='logout'),
    path('user_profile/', UserProfile.as_view(), name='user_profile'),
    path('settings/', Settings.as_view(), name='settings'),
    path('donation_details/<int:id>', DonationDetails.as_view(), name = 'donation_details'),
    path('send_contact/', SendContact, name = 'send_contact'),
    
    path('reset/', auth_views.PasswordResetView.as_view(
        template_name = 'reset_password.html',
        email_template_name = 'password_reset_emai.html',
        subject_template_name = 'password_reset_subject.txt'),
        name = 'reset_password'),
    path('reset/done/', auth_views.PasswordResetDoneView.as_view(
        template_name='reset_password_done.html'),
        name = 'reset_password_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(
        template_name = 'reset_password_confirm.html'),
        name = 'reset_password_confirm'),
    path('reset/complete/', auth_views.PasswordResetCompleteView.as_view(
        template_name = 'reset_password_complete.html'),
        name = 'reset_password_complete')

]