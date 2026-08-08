class Bibliotecario < ApplicationRecord
  acts_as_paranoid # soft delete

  enum :papel, { comum: 0, admin: 1 } # níveis de acesso

  # Módulos do devise (autenticação)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nome, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :senha_obrigatoria_no_primeiro_acesso

  def self.ransackable_attributes(auth_object = nil)
    [ "nome", "email", "papel" ]
  end

  private

  def senha_obrigatoria_no_primeiro_acesso
    if obrigar_troca_senha && password.blank?
      errors.add(:password, "precisa ser alterada no primeiro acesso por questões de segurança")
    end
  end

end
