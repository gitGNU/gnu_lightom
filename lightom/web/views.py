from django.shortcuts import render
from .models import Concentrador


def index(request):
    concentradores = Concentrador.objects.order_by('serial')
    context = {'concentradores':concentradores}
    return render(request, "web/concentrador.html", context)
