class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :username])
  end




  private

  def require_user_logged_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
