class BibliotecarioMailer < ApplicationMailer
  default from: 'nao-responda@bibliotecamunicipal.rn.gov.br'

  def boas_vindas(bibliotecario, senha_provisoria)
    @bibliotecario = bibliotecario
    @senha_provisoria = senha_provisoria

    mail(
      to: @bibliotecario.email,
      subject: 'Bem-vindo(a) ao Sistema da Biblioteca - Suas Credenciais de Acesso'
    )
  end
end