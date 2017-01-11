from django.db import models


class Concentrador(models.Model):
    serial = models.CharField(max_length=100, primary_key=True,
                              help_text='Número serial')
    latitude = models.CharField(max_length=100,
                                help_text='Coordenada de latitude')
    longitude = models.CharField(max_length=100,
                                 help_text='Coordenada de longitude')
    ip = models.GenericIPAddressField('IP', help_text='Endereço de rede')
    atualizacao = models.DateTimeField('Atualização',
                                       help_text='Última atualização')

    class Meta:
        verbose_name = "Concentrador"
        verbose_name_plural = "Concentradores"

    def __str__(self):
        return self.serial


class Programar(models.Model):
    codigo = models.PositiveSmallIntegerField(primary_key=True,
                                              help_text="Nome da programação")
    inicio = models.DateTimeField('Início',
                                  help_text='Horário de início')
    fim = models.DateTimeField(help_text='Horário de término')

    def __str__(self):
        self.codigo = str(self.codigo)
        return self.codigo


class ProgramarEstado(Programar):
    ESTADO_CHOICES = (
        ('ON', 'Ligar'),
        ('OFF', 'Desligar')
    )
    acao = models.CharField('Ação', max_length=3,
                            choices=ESTADO_CHOICES,
                            help_text='Ação programada')

    class Meta:
        verbose_name = "Programar Estado"
        verbose_name_plural = "Programar Estados"


class ProgramarDimerizacao(Programar):
    nivel = models.PositiveSmallIntegerField('Nível',
                                             help_text='Nível de dimerização')

    class Meta:
        verbose_name = "Programar Dismerização"
        verbose_name_plural = "Programar Dismerizações"


class Dispositivo(models.Model):
    serial = models.CharField(max_length=100, primary_key=True,
                              help_text='Número serial')
    estado = models.BooleanField(help_text='Estado da lâmpada')
    dimerizacao = models.PositiveSmallIntegerField('Dimerização',
                                                   help_text='Nível de \
dimerização')
    potencia = models.PositiveIntegerField('Potência',
                                            help_text='Potência atual')
    tensao = models.PositiveIntegerField('Tensão',
                                          help_text='Tensão atual')
    corrente = models.PositiveIntegerField(help_text='Corrente atual')
    fase = models.PositiveIntegerField(help_text='Fase atual')
    latitude = models.CharField(max_length=100,
                                help_text='Coordenada de latitude')
    longitude = models.CharField(max_length=100,
                                 help_text='Coordenada de longitude')
    ip = models.GenericIPAddressField('IP',
                                      help_text='Endereço de rede')
    atualizacao = models.DateTimeField('Atualização',
                                       help_text='Última atualização')
    concentrador = models.ForeignKey(Concentrador,
                                     help_text='Concentrador relacionado')
    programar_estado = models.ManyToManyField(ProgramarEstado, blank=True,
                                              help_text='Programar estado \
relacionada')
    programar_dimerizacao = models.ManyToManyField(ProgramarDimerizacao,
                                                   blank=True,
                                                   help_text='Programar \
dimerizacao relacionada')

    class Meta:
        verbose_name = "Dispositivo"
        verbose_name_plural = "Dispositivos"

    def __str__(self):
        return self.serial


class Suporte(models.Model):
    usuario = models.CharField('Usuário', primary_key=True,
                               max_length=100,
                               help_text='Usuário do telegram')
    descricao = models.TextField('Descrição',
                                 help_text='Descrição do usuário')

    class Meta:
        verbose_name = "Suporte"
        verbose_name_plural = "Suportes"

    def __str__(self):
        return self.usuario
