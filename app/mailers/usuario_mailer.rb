class UsuarioMailer < ApplicationMailer
  default from: 'nao-responda@bibliotecamunicipal.rn.gov.br'

  def enviar_senha_emprestimo(usuario)
    @usuario = usuario

    mail(
      to: @usuario.email,
      subject: 'Biblioteca Municipal - Sua Senha de Empréstimo'
    )
  end
end