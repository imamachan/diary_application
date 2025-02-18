class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to diary_path(comment.diary)
    else
      redirect_to diary_path(comment.diary)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(diary_id: params[:diary_id])
  end
end
