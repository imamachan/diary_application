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
      flash[:notice] = "日記が投稿されました"
      redirect_to diaries_path
    else
      flash[:alert] = "日記の投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

   private

  def diary_params
    params.require(:diary).permit(:title, :body)
  end
end
