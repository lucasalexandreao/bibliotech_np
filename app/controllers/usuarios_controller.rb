class UsuariosController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Usuario.ransack(params[:q])
    @pagy, @usuarios = pagy(:offset, @q.result(distinct: true).order(:nome), limit: 5)
  end

  def new
  end

  def create
    if @usuario.save
      UsuarioMailer.enviar_senha_emprestimo(@usuario).deliver_now

      redirect_to usuarios_path, notice: 'Usuário cadastrado com sucesso. A senha de empréstimo foi enviada por e-mail.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @usuario.update(usuario_params)
      redirect_to usuarios_path, notice: 'Dados do usuário atualizados com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario.destroy
    redirect_to usuarios_path, notice: 'Usuário removido com sucesso.'
  end

  private

  def usuario_params
    params.require(:usuario).permit(:nome, :cpf, :telefone, :email)
  end
end