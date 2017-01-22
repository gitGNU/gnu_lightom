from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^concentradores/$', views.concentrador_list),
    url(r'^concentradores/(?P<pk>[\w{}.-]{1,50})/$', views.concentrador_detail),
    url(r'^(?P<pk>[\w{}.-]{1,50})/dispositivos/$', views.dispositivo_list),
    url(r'^dispositivos/(?P<pk>[\w{}.-]{1,50})/$', views.dispositivo_detail),
]
