class BookmarksController < ApplicationController
  def create
    Rails.logger.debug "Current user: #{current_user.inspect}"
    @diary = Diary.find(params[:diary_id])
    @bookmark = current_user.bookmarks.new(diary: @diary)

    if @bookmark.save
      unless Notification.exists?(user: @diary.user, notifier_id: current_user.id, diary: @diary, action: "bookmarked")
      Notification.create!(
        user_id: @diary.user.id,  # 通知を受け取るユーザー
        notifier: current_user,
        diary_id: @diary.id,
        action: "bookmarked",
        read: false
      )
      end
      flash[:success] = t("defaults.flash_messages.created", item: "ブックマーク")
      redirect_to diary_path(@diary)
    else
      flash[:danger] = t("defaults.flash_messages.not_created", item: "ブックマーク")
      redirect_to diary_path(@diary), status: :unprocessable_entity
    end
end


  def destroy
    @diary = current_user.bookmarks.find(params[:id]).diary
    current_user.unbookmark(@diary)
  end
end
