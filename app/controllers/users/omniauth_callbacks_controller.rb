class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def line
    basic_action
  end

  private

  def callback_from(provider)
   provider = provider.to_s

   @user = User.find_for_oauth(request.env['omniauth.auth'])

   if @user.persisted?
     flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
     sign_in_and_redirect @user, event: :authentication
   else
     session["devise.#{provider}_data"] = request.env['omniauth.auth']
     redirect_to new_user_registration_url
   end
 end

 def basic_action
   @omniauth = request.env['omniauth.auth']
   if @omniauth.present?
     @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
     if @profile
       @profile.set_values(@omniauth)
       sign_in(:user, @profile)
     else
       @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
       email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
       @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20], image: @omniauth["info"]["image"])
       @profile.set_values(@omniauth)
       sign_in(:user, @profile)
       # redirect_to edit_user_path(@profile.user.id) and return
     end
   end
   flash[:notice] = "ログインしました"
   redirect_to root_path
 end


 def fake_email(uid,provider)
    return "#{auth.uid}-#{auth.provider}@example.com"
 end
end
