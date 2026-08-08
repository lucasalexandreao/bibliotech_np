class Livro < ApplicationRecord
  belongs_to :categoria

  mount_uploader :capa, CapaUploader

  enum :status, { disponivel: 0, emprestado: 1}

  validates :titulo, :autor, :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "titulo", "autor", "status", "categoria_id", "created_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "categoria" ]
  end
end
