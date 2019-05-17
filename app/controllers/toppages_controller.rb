class ToppagesController < ApplicationController
  def index
    if logged_in?
      @shop = current_user.shops.build
      @q = current_user.shops.ransack(params[:q])
      @shops = @q.result(distinct: true).recent
    end
  end
end
