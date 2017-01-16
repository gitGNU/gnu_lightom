from django.shortcuts import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from .models import Concentrador
from .serializers import ConcentradorSerializer


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
    List all code concentrador, or create a new concentrador
    """
    if request.method == 'GET':
        concentrador = Concentrador.objects.all()
        serializer = ConcentradorSerializer(concentrador, many=True)
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
    Retrieve, update or delete a code concentrador.
    """
    try:
        concentrador = Concentrador.objects.get(pk=pk)
    except Concentrador.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ConcentradorSerializer(concentrador)
        return JSONResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ConcentradorSerializer(concentrador, data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data)
        return JSONResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        concentrador.delete()
        return HttpResponse(status=204)
