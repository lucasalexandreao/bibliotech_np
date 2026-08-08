require "test_helper"

class UsuarioMailerTest < ActionMailer::TestCase
  test "senha_emprestimo" do
    mail = UsuarioMailer.senha_emprestimo
    assert_equal "Senha emprestimo", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
