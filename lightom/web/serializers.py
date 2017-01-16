from rest_framework import serializers
from .models import Concentrador


class ConcentradorSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Concentrador
        fields = ('serial', 'latitude', 'longitude', 'ip', 'atualizacao')
