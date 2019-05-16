class ShopsController < ApplicationController

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

  private

  def shop_params
    params.require(:shop).permit(:shopname, :content, :starttime, :finishtime, :charge, :place)
  end
end
