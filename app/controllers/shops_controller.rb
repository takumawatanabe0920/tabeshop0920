class ShopsController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).recent.page(params[:page])
    @shop = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end


  private

  def shop_params
    params.require(:shop).permit(:shopname, :category, :charge, :content, :place, :image, :finishtime, :starttime)
  end
end
