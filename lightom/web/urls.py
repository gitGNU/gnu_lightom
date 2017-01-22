from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^$', views.concentradores, name="concentradores"),
    url(r'^concentrador/(?P<pk>[\w{}.-]{1,50})/$', views.dispositivos,
        name="dispositivos"),
]
