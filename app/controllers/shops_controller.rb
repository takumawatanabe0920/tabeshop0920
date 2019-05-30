class ShopsController < ApplicationController
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


  private

  def shop_params
    params.require(:shop).permit(:shopname, :category, :charge, :content, :place, :image, :finishtime, :starttime)
  end
end
