class DiariesController < ApplicationController
  before_action :require_login

  def index
    @diaries = Diary.includes(:user)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path, success: "日記が投稿されました"
    else
      render :new, status: :unprocessable_entity, danger: "日記の投稿に失敗しました"
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @comment = Comment.new
    @comments = @diary.comments.includes(:user).order(created_at: :desc)
  end

   private

  def diary_params
    params.require(:diary).permit(:title, :body, :diary_image, :diary_image_cache, :date, :weather, :emotion)
  end
end
