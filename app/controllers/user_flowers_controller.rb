class UserFlowersController < ApplicationController
  def index
    @user_flowers = current_user.user_flowers.includes(:flower)
  end
end
