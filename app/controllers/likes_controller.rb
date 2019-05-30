class LikesController < ApplicationController
  def like
    @likes = current_user.likes.page(params[:page])
  end
end
