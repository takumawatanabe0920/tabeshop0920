class Admins::ShopsController < Admins::ApplicationController
  before_action :authenticate_user!
  def new
    @shop = current_admin.shops.build
  end

  def create
    @shop = current_admin.shops.build(shop_params)
    if @shop.save!
      flash[:success] = "登録しました"
      redirect_to root_url
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def destroy
    @shop.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def shop_params
    params.require(:shop).permit(:shopname, :category, :charge, :content, :place, :image, :finishtime, :starttime)
  end
end
