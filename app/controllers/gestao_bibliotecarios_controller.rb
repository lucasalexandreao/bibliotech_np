class GestaoBibliotecariosController < ApplicationController
  before_action :authenticate_bibliotecario!
  load_and_authorize_resource class: "Bibliotecario", instance_name: :bibliotecario, param_method: :bibliotecario_params

  def index
    # Inicializa a busca com os parâmetros da URL
    @q = Bibliotecario.ransack(params[:q])
    
    # Executa a busca e passa o resultado para o Pagy paginar
    @pagy, @bibliotecarios = pagy(:offset, @q.result(distinct: true).order(:nome), limit: 1)
  end

  def new
  end

  def create
    if @bibliotecario.save
      redirect_to gestao_bibliotecarios_path, notice: 'Bibliotecário cadastrado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Permite atualizar sem exigir preenchimento de nova senha
    if params[:bibliotecario][:password].blank?
      params[:bibliotecario].delete(:password)
      params[:bibliotecario].delete(:password_confirmation)
    end

    if @bibliotecario.update(bibliotecario_params)
      redirect_to gestao_bibliotecarios_path, notice: 'Cadastro atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bibliotecario.destroy # Graças ao acts_as_paranoid, isso fará um soft delete
    redirect_to gestao_bibliotecarios_path, notice: 'Bibliotecário removido do sistema.'
  end

  private

  def bibliotecario_params
    params.require(:bibliotecario).permit(:nome, :email, :password, :password_confirmation, :papel)
  end
end