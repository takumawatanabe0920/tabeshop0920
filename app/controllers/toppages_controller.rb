class ToppagesController < ApplicationController
  def index
    if logged_in?
      @shop = current_user.shops.build
      @shops = current_user.shops.recent.page(params[:page])
    end
  end
end
