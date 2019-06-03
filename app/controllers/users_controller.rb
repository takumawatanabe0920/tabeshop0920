class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
    @count_like = @user.likes.count
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).recent.page(params[:page])
  end
end
