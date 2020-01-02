class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
