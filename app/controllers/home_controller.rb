class HomeController < ApplicationController
  def index
    @total_acervo = Livro.count
    @livros_disponiveis = Livro.disponivel.count
    @total_leitores = Usuario.count
    @emprestimos_ativos = Emprestimo.ativo.count

    @emprestimos_atrasados = Emprestimo.ativo
                                       .where("data_devolucao_prevista < ?", Date.current)
                                       .includes(:livro, :usuario)
                                       .order(data_devolucao_prevista: :asc)
  end
end
