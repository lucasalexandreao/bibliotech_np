class AjustarIndexEmailBibliotecarios < ActiveRecord::Migration[8.0]
  def change
    remove_index :bibliotecarios, :email
    add_index :bibliotecarios, :email, unique: true, where: "deleted_at IS NULL"
  end
end
