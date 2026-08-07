# Preview all emails at http://localhost:3000/rails/mailers/bibliotecario_mailer
class BibliotecarioMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/bibliotecario_mailer/boas_vindas
  def boas_vindas
    BibliotecarioMailer.boas_vindas
  end
end
