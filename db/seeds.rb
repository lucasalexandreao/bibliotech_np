# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
puts "Limpando a tabela de bibliotecários..."
Bibliotecario.with_deleted.destroy_all

puts "Criando Administrador raiz..."
Bibliotecario.create!(
  nome: "Administrador do Sistema",
  email: "admin@mossoro.rn.gov.br",
  password: "senha_segura_123",
  password_confirmation: "senha_segura_123",
  papel: :admin,
  obrigar_troca_senha: false # O admin já é criado com acesso livre
)

puts "Criando Bibliotecário comum..."
Bibliotecario.create!(
  nome: "João Silva",
  email: "joao.silva@mossoro.rn.gov.br",
  password: "senha_provisoria",
  password_confirmation: "senha_provisoria",
  papel: :comum,
  obrigar_troca_senha: true # Vai exigir a troca no primeiro acesso
)

puts "Seeds cadastradas com sucesso!"
