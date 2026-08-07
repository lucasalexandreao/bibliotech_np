class Bibliotecarios::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    senha_preenchida = params[:password].present?
    
    # Tenta atualizar dados (exige a senha atual para confirmar a ação)
    atualizado = super
    

    if atualizado && resource.obrigar_troca_senha? && senha_preenchida
      resource.update_column(:obrigar_troca_senha, false) # Desativa a trava da senha
    end
    
    atualizado
  end
end