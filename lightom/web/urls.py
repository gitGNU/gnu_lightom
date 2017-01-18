from django.conf.urls import url
from . import api, views


urlpatterns = [
    url(r'/concentradores/$', views.concentradores, name="concentradores"),
    url(r'/(?P<pk>[\w{}.-]{1,50})/dispositivos/$', views.dispositivos,
        name="dispositivos"),
    url(r'/api/concentradores/$', api.concentrador_list),
    url(r'/api/concentradores/(?P<pk>[\w{}.-]{1,50})/$',
        api.concentrador_detail),
    url(r'/api/dispositivos/$', api.dispositivo_list),
    url(r'/api/(?P<pk>[\w{}.-]{1,50})/dispositivos$', api.dispositivo_detail),
]
