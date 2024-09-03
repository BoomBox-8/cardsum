from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='summ-home'),
    path('about/', views.about, name='summ-about'),
    path('summarize/', views.summarize, name = 'summ-summarizer'),
    path('login/', views.login, name='summ-login'),
    path('register/', views.register, name='summ-register')
]