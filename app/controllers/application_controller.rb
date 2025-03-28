class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_login
  add_flash_types :success, :danger
  include Sorcery::Controller


  private

  def not_authenticated
    flash[:alert] = "ログインしてください"
    redirect_to login_path
  end
end
