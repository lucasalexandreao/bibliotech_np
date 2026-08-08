class CreateLivros < ActiveRecord::Migration[8.0]
  def change
    create_table :livros do |t|
      t.string :titulo, null: false
      t.string :autor, null: false
      t.string :capa
      t.integer :status, default: 0, null: false
      t.text :observacoes
      t.references :categoria, null: false, foreign_key: true

      t.timestamps
    end
  end
end
