class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

  def new
    @hide_header_footer = true
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to diaries_path, success: t("defaults.flash_messages.login_success")
    else
      @hide_header_footer = true
      flash.now[:danger] = t("defaults.flash_messages.login_failed")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
