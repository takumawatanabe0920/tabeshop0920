class ShopsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def show
    @shop = current_user.shops.find(params[:id])
  end

  def new
    @shop = current_user.shops.build
    @shops = current_user.shops.recent.page(params[:page])
  end

  def create
    @shop = current_user.shops.build(shop_params)

    if @shop.save
      flash[:success] = "登録しました"
      redirect_to root_url
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def update
  end

  def edit
  end

  def destroy
    @shop.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end



  private

  def shop_params
    params.require(:shop).permit(:shopname, :content, :starttime, :finishtime, :charge, :place, :category, :picture)
  end

  def correct_user
    @shop = current_user.shops.find_by(id: params[:id])
    unless @shop
      redirect_to root_url
    end
  end
end
