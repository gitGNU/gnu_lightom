from django.db import models


class Programar(models.Model):
    inicio = models.DateTimeField('Início',
                                  help_text='Horário de início')
    fim = models.DateTimeField('Fim',
                               help_text='Horário de término')


class ProgramarEstado(Programar):
    class Meta:
        ordering = ["dispositivo"]

    ESTADO_CHOICES = (
        ('ON', 'Ligar'),
        ('OFF', 'Desligar')
    )
    acao = models.CharField('Ação', max_length=3,
                            choices=ESTADO_CHOICES,
                            help_text='Ação programada')


class ProgramarDimerizacao(Programar):
    nivel = models.PositiveSmallIntegerField('Nível',
                                             help_text='Nível de dimerização')


class Dispositivo(models.Model):
    concentrador = models.ForeignKey('Concentrador', 
                                     help_text='Concentrador relacionado')
    programar_estado = models.ManyToManyField('ProgramarEstado', blank=True,
                                         help_text='Programar estado relacionada')
    programar_dimerizacao = models.ManyToManyField('ProgramarDimerizacao', blank=True,
                                              help_text='Programar dimerizacao relacionada')
    serial = models.CharField('Serial', max_length=100,
                              help_text='Número serial')
    estado = models.BooleanField('Estado', help_text='Estado da lâmpada')
    dimerizacao = models.PositiveSmallIntegerField('Dismerização',
                                                   help_text='Nível de dimerização')
    potencia = models.PositiveIntegerField('Potência',
                                            help_text='Potência atual')
    tensao = models.PositiveIntegerField('Tensão',
                                          help_text='Tensão atual')
    corrente = models.PositiveIntegerField('Corrente',
                                            help_text='Corrente atual')
    fase = models.PositiveIntegerField('Fase',
                                        help_text='Fase atual')
    latitude = models.CharField('Latitude', max_length=100,
                                help_text='Coordenada de latitude')
    longitude = models.CharField('Longitude', max_length=100,
                                 help_text='Coordenada de longitude')
    ip = models.GenericIPAddressField('IP',
                                      help_text='Endereço de rede')
    atualizacao = models.DateTimeField('Atualização',
                                       help_text='Última atualização')


class Concentrador(models.Model):
    serial = models.CharField('Serial', max_length=100,
                              help_text='Número serial')
    latitude = models.CharField('Latitude', max_length=100,
                                help_text='Coordenada de latitude')
    longitude = models.CharField('Longitude', max_length=100,
                                 help_text='Coordenada de longitude')
    ip = models.GenericIPAddressField('IP',
                                      help_text='Endereço de rede')
    atualizacao = models.DateTimeField('Atualização',
                                       help_text='Última atualização')


class Suporte(models.Model):
    usuario = models.CharField('Usuário', max_length=50,
                               help_text='Usuário do telegram')
    descricao = models.TextField('Descrição',
                                 help_text='Descrição do usuário')
