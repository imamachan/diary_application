class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to diary_path(@notification.diary)
  end

  def destroy
  @notification = current_user.notifications.find(params[:id])
  @notification.destroy

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to notifications_path }
  end
end
end
