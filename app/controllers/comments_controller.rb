class CommentsController < ApplicationController
  def create
    Rails.logger.debug "Current user: #{current_user.inspect}"
    @comment = current_user.comments.build(comment_params)
    @diary = @comment.diary

    if @comment.save
      unless Notification.exists?(user: @diary.user, notifier_id: current_user.id, diary: @diary, action: "commented")
      Notification.create!(
        user_id: @diary.user.id,  # 通知を受け取るユーザー
        notifier: current_user,
        diary_id: @diary.id,
        action: "commented",
        read: false
      )
      end
      flash.now[:success] = t("defaults.flash_messages.created", item: Comment.model_name.human)
      redirect_to diary_path(@diary)
    else
      flash.now[:danger] = t("defaults.flash_messages.not_created", item: Comment.model_name.human)
      render "diaries/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @diary = @comment.diary
    if @comment.destroy
      flash.now[:success] = t("defaults.flash_messages.deleted", item: Comment.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_messages.not_deleted", item: Comment.model_name.human)
    end
  end

  def my_comments
    @comments = Comment.includes(:user, :diary)
                       .where(diary: current_user.diaries)
                       .order(created_at: :desc)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(diary_id: params[:diary_id])
  end
end
