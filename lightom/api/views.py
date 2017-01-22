from django.shortcuts import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from web.models import Concentrador, Dispositivo
from .serializers import ConcentradorSerializer, DispositivoSerializer


class JSONResponse(HttpResponse):
    """
    An HttpResponse that renders its content into JSON.
    """
    def __init__(self, data, **kwargs):
        content = JSONRenderer().render(data)
        kwargs['content_type'] = 'application/json'
        super(JSONResponse, self).__init__(content, **kwargs)

@csrf_exempt
def concentrador_list(request):
    """
    List all, or create a new
    """
    if request.method == 'GET':
        query = Concentrador.objects.all()
        serializer = ConcentradorSerializer(query, many=True)
        return JSONResponse(serializer.data)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ConcentradorSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)

@csrf_exempt
def concentrador_detail(request, pk):
    """
    Retrieve, update or delete a code
    """
    try:
        query = Concentrador.objects.get(pk=pk)
    except Concentrador.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ConcentradorSerializer(query)
        return JSONResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ConcentradorSerializer(query, data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data)
        return JSONResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        query.delete()
        return HttpResponse(status=204)

    
@csrf_exempt
def dispositivo_list(request):
    """
    List all, or create a new
    """
    if request.method == 'GET':
        query = Dispositivo.objects.all()
        serializer = DispositivoSerializer(query, many=True)
        return JSONResponse(serializer.data)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = DispositivoSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)

@csrf_exempt
def dispositivo_detail(request, pk):
    """
    Retrieve, update or delete a code
    """
    try:
        query = Dispositivo.objects.get(pk=pk)
    except Dispositivo.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = DispositivoSerializer(query)
        return JSONResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = DispositivoSerializer(query, data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data)
        return JSONResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        query.delete()
        return HttpResponse(status=204)
