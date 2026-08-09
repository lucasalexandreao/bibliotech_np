class PortalController < ApplicationController
  skip_before_action :authenticate_bibliotecario!

  def login
  end

  def autenticar
    cpf_limpo = params[:cpf].to_s.gsub(/\D/, '')
    usuario = Usuario.find_by(cpf: cpf_limpo)

    if usuario && usuario.authenticate(params[:senha_emprestimo])
      session[:leitor_id] = usuario.id
      redirect_to portal_meus_emprestimos_path, notice: "Bem-vindo ao Portal do Leitor, #{usuario.nome}!"
    else
      flash.now[:alert] = "CPF ou Senha incorretos."
      render :login, status: :unprocessable_entity
    end
  end

  def logout
    session[:leitor_id] = nil
    redirect_to portal_login_path, notice: "Sessão encerrada com sucesso."
  end

  def meus_emprestimos
    @usuario = Usuario.find_by(id: session[:leitor_id])

    if @usuario.nil?
      redirect_to portal_login_path, alert: "Você precisa fazer login para acessar seus empréstimos."
      return
    end

    @emprestimos = @usuario.emprestimos.ativo.order(data_devolucao_prevista: :asc)
  end

  def renovar
    @usuario = Usuario.find_by(id: session[:leitor_id])
    @emprestimo = @usuario.emprestimos.find(params[:id])

    if @emprestimo.renovar!
      redirect_to portal_meus_emprestimos_path, notice: "Livro renovado! Novo prazo: #{l(@emprestimo.data_devolucao_prevista)}"
    else
      redirect_to portal_meus_emprestimos_path, alert: "Não foi possível renovar este livro. Verifique se não está atrasado."
    end
  end
end