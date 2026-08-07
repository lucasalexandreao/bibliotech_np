class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :authenticate_bibliotecario!
  before_action :exigir_troca_senha

  private

  def exigir_troca_senha
    return if !bibliotecario_signed_in? || devise_controller?

    if current_bibliotecario.obrigar_troca_senha?
      flash[:alert] = "Altere sua senha provisória para uma senha definitiva."
      redirect_to edit_bibliotecario_registration_path
    end
  end
end
