class EmprestimosController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Emprestimo.ransack(params[:q])
    @pagy, @emprestimos = pagy(:offset, @q.result.includes(:livro, :usuario).order(created_at: :desc), limit: 10)
  end

  def new
    @livro = Livro.find(params[:livro_id])
    @emprestimo = @livro.emprestimos.build

    unless @livro.disponivel?
      redirect_to livros_path, alert: "Este exemplar já está emprestado."
    end
  end

  def create
    @livro = Livro.find(params[:livro_id])
    @emprestimo = @livro.emprestimos.build(emprestimo_params)

    if @emprestimo.save
      redirect_to livros_path, notice: "Empréstimo realizado com sucesso! Devolução prevista para #{l(@emprestimo.data_devolucao_prevista)}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def devolver
    @emprestimo = Emprestimo.find(params[:id])

    if @emprestimo.ativo?
      @emprestimo.registrar_devolucao!
      redirect_back fallback_location: emprestimos_path, notice: "Livro devolvido com sucesso! O exemplar já está disponível no acervo."
    else
      redirect_back fallback_location: emprestimos_path, alert: "Este empréstimo já consta como devolvido."
    end
  end

  def renovar
    @emprestimo = Emprestimo.find(params[:id])

    if @emprestimo.renovar!
      redirect_back fallback_location: emprestimos_path, notice: "Empréstimo renovado com sucesso! Novo prazo: #{l(@emprestimo.data_devolucao_prevista)}"
    else
      redirect_back fallback_location: emprestimos_path, alert: 'Não foi possível renovar. O empréstimo está atrasado ou inativo.'
    end
  end

  private

  def emprestimo_params
    params.require(:emprestimo).permit(:usuario_id, :senha_emprestimo_digitada)
  end
end