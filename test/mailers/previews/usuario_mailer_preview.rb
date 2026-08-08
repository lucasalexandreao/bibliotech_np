# Preview all emails at http://localhost:3000/rails/mailers/usuario_mailer
class UsuarioMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/usuario_mailer/senha_emprestimo
  def senha_emprestimo
    UsuarioMailer.senha_emprestimo
  end
end
