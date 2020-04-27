from django.shortcuts import render
from django.views import View
from django.views.generic import TemplateView

class IndexPage(View):
    def get(self, request):
        return render(request, 'index.html')

# class IndexPage(TemplateView):
#     template_name = 'index.html'

class AddDonation(View):
    def get(self, request):
        return render(request, 'form.html')

class Login(View):
    def get(self, request):
        return render(request, 'login.html')

class Register(View):
    def get(self, request):
        return render(request, 'register.html')
