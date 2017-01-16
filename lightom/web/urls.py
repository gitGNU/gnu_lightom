from django.conf.urls import url
from . import api


urlpatterns = [
    url(r'^concentrador/$', api.concentrador_list),
    url(r'^concentrador/(?P<pk>[\w{}.-]{1,50})/$', api.concentrador_detail),
]
