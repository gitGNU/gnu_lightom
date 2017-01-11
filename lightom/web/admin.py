from django.contrib import admin
from .models import Concentrador, Dispositivo, \
    ProgramarEstado, ProgramarDimerizacao, Suporte


class ConcentradorAdmin(admin.ModelAdmin):
    list_display = ['serial', 'ip', 'atualizacao']
    verbose_name = "Concentrador"
    verbose_name_plural = "concentradores"
    


admin.site.register(Concentrador, ConcentradorAdmin)
admin.site.register(Dispositivo)
admin.site.register(ProgramarEstado)
admin.site.register(ProgramarDimerizacao)
admin.site.register(Suporte)
