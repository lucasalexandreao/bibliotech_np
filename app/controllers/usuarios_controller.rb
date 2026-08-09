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
      
      respond_to do |format|
        if params[:livro_id].present?
          format.turbo_stream do
            @livro = Livro.find(params[:livro_id])
            @emprestimo = @livro.emprestimos.build(usuario_id: @usuario.id)
            
            flash.now[:notice] = "Leitor cadastrado com sucesso! A senha foi enviada por e-mail."
            render "emprestimos/new" 
          end
        else
          format.html { redirect_to usuarios_path, notice: 'Usuário cadastrado com sucesso. A senha foi enviada por e-mail.' }
        end
      end
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
    if @usuario.destroy
      redirect_to usuarios_path, notice: 'Usuário removido com sucesso.'
    else
      redirect_to usuarios_path, alert: 'Não é possível remover este leitor, pois há um histórico de empréstimos associado a ele'
    end
  end

  private

  def usuario_params
    params.require(:usuario).permit(:nome, :cpf, :telefone, :email)
  end
end