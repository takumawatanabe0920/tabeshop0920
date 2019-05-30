class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    shop = Shop.find(params[:like_id])
    current_user.like(shop)
    flash[:success] = "お気に入りに追加しました"
    redirect_to root_url
  end

  def destroy
    shop = Shop.find(params[:like_id])
    current_user.unlike(shop)
    flash[:success] = "お気に入りを解除しました"
    redirect_to root_url
  end
end
