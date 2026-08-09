puts "🧹 Limpando o banco de dados..."
Emprestimo.destroy_all
Livro.destroy_all
Categoria.destroy_all
Usuario.destroy_all
Bibliotecario.with_deleted.destroy_all

puts "👤 Criando Bibliotecários..."
6.times do |i|
  Bibliotecario.create!(
    nome: "Bibliotecário #{i + 1}",
    email: "biblio#{i + 1}@biblioteca.com",
    password: "senha#{i + 1}2345", 
    password_confirmation: "senha#{i + 1}2345",
    papel: i.even? ? 1 : 0,
    obrigar_troca_senha: false
  )
end

puts "📚 Criando Categorias..."
categorias_nomes = ["Ficção Científica", "Romance Clássico", "História do Brasil", "Tecnologia e Programação", "Biografias", "Literatura Fantástica"]
categorias = categorias_nomes.map do |nome|
  Categoria.create!(nome: nome)
end

puts "👥 Criando Usuários (Leitores)..."
usuarios = []
6.times do |i|
  usuarios << Usuario.create!(
    nome: "Leitor Exemplo #{i + 1}",
    cpf: "1234567890#{i}",
    telefone: "8499999999#{i}",
    email: "leitor#{i + 1}@email.com",
    password: "SENHA123"
  )
end

puts "📖 Criando Livros..."
livros_data = [
  { titulo: "O Guia do Mochileiro das Galáxias", autor: "Douglas Adams", obs: "Edição de capa dura" },
  { titulo: "Dom Casmurro", autor: "Machado de Assis", obs: "Livro exigido no vestibular" },
  { titulo: "1808", autor: "Laurentino Gomes", obs: "Bom estado de conservação" },
  { titulo: "Clean Code", autor: "Robert C. Martin", obs: "Exemplar em inglês" },
  { titulo: "Steve Jobs", autor: "Walter Isaacson", obs: "Biografia completa" },
  { titulo: "O Senhor dos Anéis: A Sociedade do Anel", autor: "J.R.R. Tolkien", obs: "Primeiro volume" }
]

livros = livros_data.map.with_index do |dados, index|
  Livro.create!(
    titulo: dados[:titulo],
    autor: dados[:autor],
    observacoes: dados[:obs],
    categoria: categorias[index],
    status: 0 # disponivel
  )
end

puts "🔄 Criando Empréstimos (No prazo, Atrasados e Devolvidos)..."

data_hoje = Date.current

# 1. Empréstimo ATIVO e NO PRAZO
Emprestimo.create!(
  livro: livros[0],
  usuario: usuarios[0],
  senha_emprestimo_digitada: "SENHA123",
  data_emprestimo: data_hoje - 5.days,
  data_devolucao_prevista: data_hoje + 10.days,
  status: 0 # ativo
)

# 2. Empréstimo ATIVO e NO PRAZO 
Emprestimo.create!(
  livro: livros[1],
  usuario: usuarios[1],
  senha_emprestimo_digitada: "SENHA123",
  data_emprestimo: data_hoje - 14.days,
  data_devolucao_prevista: data_hoje + 1.day,
  status: 0 # ativo
)

# 3. Empréstimo ATRASADO 
Emprestimo.create!(
  livro: livros[2],
  usuario: usuarios[2],
  senha_emprestimo_digitada: "SENHA123",
  data_emprestimo: data_hoje - 20.days,
  data_devolucao_prevista: data_hoje - 5.days,
  status: 0 # ativo, mas com data vencida
)

# 4. Empréstimo ATRASADO
Emprestimo.create!(
  livro: livros[3],
  usuario: usuarios[3],
  senha_emprestimo_digitada: "SENHA123",
  data_emprestimo: data_hoje - 45.days,
  data_devolucao_prevista: data_hoje - 30.days,
  status: 0 # ativo, mas com data vencida
)

puts "✅ Seeds finalizados com sucesso! O banco está populado e pronto para uso."