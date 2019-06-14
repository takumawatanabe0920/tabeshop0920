class ShopsController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).recent.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews
    counts2(@shop)
    averages(@shop)
  end



  private

  def shop_params
    params.require(:shop).permit(:shopname, :category, :charge, :content, :place, :image, :finishtime, :starttime, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end
end
