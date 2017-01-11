from django.contrib import admin
from .models import Concentrador, Dispositivo, \
    ProgramarEstado, ProgramarDimerizacao, Suporte


class ConcentradorAdmin(admin.ModelAdmin):
    list_display = ['serial', 'ip', 'atualizacao']
    search_fields = ['serial']
    list_filter = ['atualizacao']


class DispositivoAdmin(admin.ModelAdmin):
    list_display = ['serial', 'estado', 'dimerizacao', 'ip', 'atualizacao']
    list_filter = ['atualizacao']
    search_fields = ['serial']
    

class ProgramarEstadoAdmin(admin.ModelAdmin):
    list_display = ['codigo', 'inicio', 'fim']
    list_filter = ['inicio']


class ProgramarDimerizacaoAdmin(admin.ModelAdmin):
    list_display = ['codigo', 'inicio', 'fim']
    list_filter = ['inicio']


class SuporteAdmin(admin.ModelAdmin):
    list_display = ['usuario']
    search_fields = ['usuario']
    

admin.site.register(Concentrador, ConcentradorAdmin)
admin.site.register(Dispositivo, DispositivoAdmin)
admin.site.register(ProgramarEstado, ProgramarEstadoAdmin)
admin.site.register(ProgramarDimerizacao, ProgramarDimerizacaoAdmin)
admin.site.register(Suporte, SuporteAdmin)
