class Emprestimo < ApplicationRecord
  belongs_to :livro
  belongs_to :usuario

  attr_accessor :senha_emprestimo_digitada

  enum :status, { ativo: 0, devolvido: 1 }

  validates :data_emprestimo, :data_devolucao_prevista, presence: true
  validate :validar_senha_usuario, on: :create
  validate :livro_deve_estar_disponivel, on: :create

  before_validation :configurar_datas, on: :create
  after_create :marcar_livro_como_emprestado

  def registrar_devolucao!
    transaction do
      update!(
        status: :devolvido,
        data_devolucao_realizada: Date.current
      )
      livro.disponivel!
    end
  end

  def pode_ser_renovado?
    ativo? && Date.current <= data_devolucao_prevista
  end

  def renovar!
    return false unless pode_ser_renovado?

    nova_data = calcular_dias_uteis(data_devolucao_prevista, 15)
    update(data_devolucao_prevista: nova_data)
  end

  private

  def configurar_datas
    self.data_emprestimo ||= Date.current
    self.status ||= :ativo

    self.data_devolucao_prevista ||= calcular_dias_uteis(self.data_emprestimo, 15)
  end

  def calcular_dias_uteis(data_inicial, dias)
    data = data_inicial
    dias.times do
      data += 1.day
      data += 1.day while data.saturday? || data.sunday?
    end

    data
  end

  def validar_senha_usuario
    return if usuario.blank?

    if senha_emprestimo_digitada.blank?
      errors.add(:senha_emprestimo_digitada, "deve ser informada")

    elsif !usuario.authenticate(senha_emprestimo_digitada.strip.upcase)
      errors.add(:senha_emprestimo_digitada, "inválida. Verifique com o leitor.")
    end
  end

  def livro_deve_estar_disponivel
    if livro && !livro.disponivel?
      errors.add(:livro, "não está disponível no momento")
    end
  end

  def marcar_livro_como_emprestado
    livro.emprestado!
  end

  # Libera atributos para os filtros do Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["status", "data_emprestimo", "data_devolucao_prevista", "data_devolucao_realizada"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["livro", "usuario"]
  end
end
