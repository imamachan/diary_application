class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

  def new
    @hide_header_footer = true
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to diaries_path, success: "ログインしました"
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
