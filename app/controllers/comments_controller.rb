class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @diary = @comment.diary
    if @comment.save
      flash.now[:success] = t("defaults.flash_messages.created", item: Comment.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_messages.not_created", item: Comment.model_name.human)
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

  private

  def comment_params
    params.require(:comment).permit(:body).merge(diary_id: params[:diary_id])
  end
end
