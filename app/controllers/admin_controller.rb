class AdminController < ApplicationController
  def new
    @shop = current_user.shops.build
  end
end
