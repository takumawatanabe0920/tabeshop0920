class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      root_path
    elsif resource.is_a?(Admin)
      admins_root_path
    end
  end

  def counts(user)
    @count_likes = user.likes.count
  end

  def counts2(shop)
    @count_reviews = shop.reviews.count
  end

  def averages(shop)
    @averages_shop_reviews = shop.reviews.average(:rate)
  end


  protected

  def configure_permitted_parameters
    added_attrs = [ :username, :email, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end



  private
  def require_user_logged_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end





end
