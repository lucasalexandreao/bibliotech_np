require "test_helper"

class BibliotecarioMailerTest < ActionMailer::TestCase
  test "boas_vindas" do
    mail = BibliotecarioMailer.boas_vindas
    assert_equal "Boas vindas", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
