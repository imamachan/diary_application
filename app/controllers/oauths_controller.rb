
class OauthsController < ApplicationController
skip_before_action :require_login
  def oauth
    logger.info "auth_params[:provider]: #{auth_params[:provider].inspect}"
    login_at(auth_params[:provider])
  end

def callback
  provider = auth_params[:provider]

  if (@user = login_from(provider))
    redirect_to diaries_path, notice: "#{provider.titleize}アカウントでログインしました"
  else
    begin
      # ユーザーが存在しない場合は、新規作成してログイン
      user = create_from(provider)
      reset_session  # セキュリティ対策のためセッションをリセット
      auto_login(user)  # 作成したユーザーをログイン

      redirect_to diaries_path, notice: "#{provider.titleize}アカウントでログインしました"
    rescue StandardError => e
      logger.error "OAuth login failed: #{e.message}"
      redirect_to root_path, alert: "#{provider.titleize}アカウントでのログインに失敗しました"
    end
  end
end

  private

  def auth_params
    params.permit(:provider)
  end
end
