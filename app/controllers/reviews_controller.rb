class ReviewsController < ApplicationController
  

  def new
    @shop = Shop.find(params[:shop_id])
    @review = Review.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @review = current_user.reviews.new(review_params)

    if @review.save
      redirect_to shop_path(@review.shop)
    else
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:title, :rate, :content).merge(shop_id: params[:shop_id])
    end
end
