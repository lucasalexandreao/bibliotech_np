class ApplicationController < ActionController::Base
  include Pagy::Method
  before_action :authenticate_bibliotecario!
  before_action :exigir_troca_senha

  private

  def current_ability
    @current_ability || Ability.new(current_bibliotecario)
  end

  def exigir_troca_senha
    return if !bibliotecario_signed_in? || devise_controller?

    if current_bibliotecario.obrigar_troca_senha?
      flash[:alert] = "Altere sua senha provisória para uma senha definitiva."
      redirect_to edit_bibliotecario_registration_path
    end
  end
end
