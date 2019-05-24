class ShopsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :authenticate_user!
  def index
    params[:q] = { starttime_eq: 1 }       if params[:starttime] == 1
    params[:q] = { starttime_lteq: 6 }  if params[:starttime] == 2
    params[:q] = { starttime_lteq: 12 }  if params[:starttime] == 3
    params[:q] = { starttime_gteq: 18 } if params[:starttime] == 4
    @q = current_user.shops.ransack(params[:q])
    @shops = @q.result(distinct: true).recent.page(params[:page])
    @shop = current_user.shops.all
  end


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
    params.require(:shop).permit(:shopname, :content, :starttime, :finishtime, :charge, :place, :category, :image)
  end

  def correct_user
    @shop = current_user.shops.find_by(id: params[:id])
    unless @shop
      redirect_to root_url
    end
  end
end
