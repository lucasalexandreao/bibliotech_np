class Bibliotecario < ApplicationRecord

  acts_as_paranoid # soft delete

  enum :papel, { comum: 0, admin: 1 } # níveis de acesso

  # Módulos do devise (autenticação)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  # Validações
  validate :senha_obrigatoria_no_primeiro_acesso

  private

  def senha_obrigatoria_no_primeiro_acesso
    if obrigar_troca_senha && password.blank?
      errors.add(:password, "precisa ser alterada no primeiro acesso por questões de segurança")
    end
  end

end
