class AtualizarSenhaEmprestimoUsuarios < ActiveRecord::Migration[8.0]
  def change
    remove_column :usuarios, :senha_emprestimo, :string
    add_column :usuarios, :password_digest, :string
  end
end
