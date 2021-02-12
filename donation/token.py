from django.contrib.auth.models import User
from django.contrib.auth.tokens import default_token_generator
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode
from django.template import loader
from django.core.mail import EmailMultiAlternatives


def token_mail(subject_template_name, email_template_name,
                  context, from_email, to_email, html_email_template_name=None):

        subject = loader.render_to_string(subject_template_name, context)
        # Email subject *must not* contain newlines
        subject = ''.join(subject.splitlines())
        body = loader.render_to_string(email_template_name, context)

        email_message = EmailMultiAlternatives(subject, body, from_email,
            [to_email])
        if html_email_template_name is not None:
            html_email = loader.render_to_string(
                html_email_template_name,
                context
            )
            email_message.attach_alternative(html_email, 'text/html')

        email_message.send()
  
def send_token(email,
            subject_template_name='templates/activate_subject.txt',
            email_template_name='templates/activate_email.html',
            use_https=False, token_generator=default_token_generator,
            from_email=None, request=None, html_email_template_name=None):
    """
    Generates a one-use only link to confirm registration
    """
    users = User.objects.filter(email=email)
    for user in users:
        current_site = get_current_site(request)
        site_name = current_site.name
        domain = current_site.domain
        context = {
            'email': user.email,
            'domain': domain,
            'site_name': site_name,
            'uid': urlsafe_base64_encode(force_bytes(user.pk)),
            'user': user,
            'token': token_generator.make_token(user),
            'protocol': 'https' if use_https else 'http',
        }

        token_mail(subject_template_name, email_template_name,
                        context, from_email, user.email,
                        html_email_template_name=html_email_template_name)