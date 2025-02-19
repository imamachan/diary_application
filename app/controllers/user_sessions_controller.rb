class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

  def new
    @hide_header_footer = true
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to diaries_path, success: t("views.flash_messages.login_success")
    else
      flash.now[:danger] = t("views.flash_messages.login_failed")
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
