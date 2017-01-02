from django.db import models


class Suporte(models.Model):
    usuario = models.CharField('Usuário', max_length=50,
                               help_text='Usuário do telegram')
    descricao = models.TextField('Descrição',
                                 help_text='Descrição do usuário')
