class LikesController < ApplicationController
  before_action :authenticate_user!
  def like
    @likes = current_user.likes.page(params[:page])
  end
end
