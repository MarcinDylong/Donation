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
from django.urls import path
from donation.views import (AddDonation, DonationDetails, IndexPage, Login,
                            Logout, Register, SendContact, Settings,
                            UserProfile, ResetPassword, ResetPasswordDone,
                            ResetPasswordComplete, ResetPasswordConfirm,
                            AccountActivation)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', IndexPage.as_view(), name="index"),
    path('add_donation/', AddDonation, name="add_donation"),
    path('login/', Login.as_view(), name="login"),
    path('register/', Register.as_view(), name="register"),
    path('logout/', Logout, name='logout'),
    path('user_profile/', UserProfile.as_view(), name='user_profile'),
    path('settings/', Settings.as_view(), name='settings'),
    path('donation_details/<int:id>', DonationDetails.as_view(),
        name = 'donation_details'),
    path('send_contact/', SendContact, name = 'send_contact'),
    path('reset/', ResetPassword.as_view(),
        name = 'password_reset'),
    path('reset/done/', ResetPasswordDone.as_view(),
        name = 'password_reset_done'),
    path('reset/<uidb64>/<token>/', ResetPasswordConfirm,
        name = 'password_reset_confirm'),
    path('reset/complete/', ResetPasswordComplete.as_view(),
        name = 'password_reset_complete'),
    path('activate/<uidb64>/<token>/', AccountActivation.as_view(), name = 'account_activation')
]

handler400 = 'donation.views.view_400'
handler403 = 'donation.views.view_403'
handler404 = 'donation.views.view_404'
handler500 = 'donation.views.view_500'