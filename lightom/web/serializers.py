from rest_framework import serializers
from .models import Concentrador, Dispositivo


class ConcentradorSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Concentrador
        fields = {'serial', 'latitude', 'longitude', 'ip', 'atualizacao'}


class DispositivoSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Dispositivo
        fields = {'serial', 'estado', 'dimerizacao', 'potencia',
                  'tensao', 'corrente', 'fase', 'latitude',
                  'longitude', 'ip', 'atualizacao', 'concentrador'}
