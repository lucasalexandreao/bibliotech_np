class CategoriasController < ApplicationController
  before_action :authenticate_bibliotecario!
  load_and_authorize_resource

  def index
    # Inicializa a busca com os parâmetros da URL
    @q = Categoria.ransack(params[:q])

    # Executa a busca e passa o resultado para o Pagy paginar
    @pagy, @categorias = pagy(:offset, @q.result(distinct: true).order(:nome), limit: 1)
  end

  def new
  end

  def create
    if @categoria.save
      redirect_to categorias_path, notice: 'Categoria cadastrada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @categoria.update(categoria_params)
      redirect_to categorias_path, notice: 'Categoria atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @categoria.destroy
    redirect_to categorias_path, notice: 'Categoria removida do sistema.'
  end

  private

  def categoria_params
    params.require(:categoria).permit(:nome)
  end
end