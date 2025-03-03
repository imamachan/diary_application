class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t("defaults.flash_messages.updated", item: User.model_name.human)
    else
      flash.now["danger"] = t("defaults.flash_messages.not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :profile_picture, :profile_picture_cache, :profile_comment)
  end
end
