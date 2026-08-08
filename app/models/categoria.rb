class Categoria < ApplicationRecord
  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  def self.ransackable_attributes(auth_object = nil)
    [ "nome" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
