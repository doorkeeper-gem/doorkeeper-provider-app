class UsersController < ApplicationController

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @user = User.create!(user_params)
    sign_in_and_redirect @user
  end

  ###
  private
  ###

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(
        :email, :password, :password_confirmation, :remember_me)
      : {}
  end
end
