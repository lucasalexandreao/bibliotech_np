class Usuario < ApplicationRecord
  has_secure_password

  attr_accessor :senha_plana

  has_many :emprestimos, dependent: :restrict_with_error

  validates :nome, :cpf, :email, :telefone, presence: true
  validates :cpf, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cpf, length: { is: 11, message: "deve conter exatamente 11 números" }
  validates :telefone, length: { in: 10..11, message: "deve conter 10 ou 11 números (com DDD)" }

  before_validation :gerar_senha_inicial, on: :create
  before_validation :limpar_formatacao

  def self.ransackable_attributes(auth_object = nil)
    [ "nome", "cpf", "email", "telefone" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def gerar_senha_inicial
    if self.password.blank?
      # Gera a senha em texto puro e guarda na memória (atributo virtual)
      self.senha_plana = SecureRandom.alphanumeric(6).upcase

      # Passa para o Bcrypt transformar no hash (password_digest)
      self.password = self.senha_plana
    end
  end

  def limpar_formatacao
    self.cpf = cpf.gsub(/\D/, '') if cpf.present?
    self.telefone = telefone.gsub(/\D/, '') if telefone.present?
  end
end
