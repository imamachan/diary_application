class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new
    @hide_header_footer = true
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    # 「存在しないメールアドレスです」という旨の文言を表示すると、逆に存在するメールアドレスを特定されてしまうため、
    # あえて成功時のメッセージを送信させている
    flash[:success] = t(".success")
    redirect_to login_path
  end

  def edit
    @hide_header_footer = true
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      flash[:success] = t(".success")
      redirect_to login_path
    else
      flash.now[:danger] = t(".fail")
      render :edit, status: :unprocessable_entity
    end
  end
end
