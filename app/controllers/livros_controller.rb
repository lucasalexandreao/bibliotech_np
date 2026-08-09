class LivrosController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Livro.ransack(params[:q])
    @pagy, @livros = pagy(:offset, @q.result(distinct: true).includes(:categoria).order(:titulo), limit: 5)
  end

  def show
  end

  def new
  end

  def create
    if @livro.save
      redirect_to livros_path, notice: 'Livro cadastrado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @livro.update(livro_params)
      redirect_to livros_path, notice: 'Livro atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @livro.destroy
      redirect_to livros_path, notice: 'Livro removido do acervo.'
    else
      redirect_to livros_path, alert: 'Não foi possível remover este livro, pois há um histórico de empréstimos associado a ele'
    end
  end

  private

  def livro_params
    params.require(:livro).permit(:titulo, :autor, :status, :categoria_id, :observacoes, :capa, :capa_cache)
  end
end