class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create show]

  def new
    @hide_header_footer = true
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      @hide_header_footer = true
      flash.now[:danger] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
