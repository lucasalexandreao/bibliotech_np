class Bibliotecario < ApplicationRecord
  acts_as_paranoid # soft delete

  enum :papel, { comum: 0, admin: 1 } # níveis de acesso

  # Módulos do devise (autenticação)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # validações manuais em vez do módulo :validatable por causa do soft delete
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { conditions: -> { where(deleted_at: nil) } }, if: :email_changed?
  validates :password, presence: true, length: { in: 6..128 }, on: :create
  validates :password, length: { in: 6..128 }, allow_blank: true, on: :update

  validates :nome, presence: true
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
