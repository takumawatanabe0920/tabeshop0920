class ReviewsController < ApplicationController
  def new
    @shop = Shop.find(params[:shop_id])
  end
end
