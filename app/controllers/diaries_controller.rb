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

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path(@diary), success: t("defaults.flash_messages.updated", item: Diary.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_messages.not_updated", item: Diary.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

   def destroy
    diary = current_user.diaries.find(params[:id])
    diary.destroy!
    redirect_to diaries_path, success: t("defaults.flash_messages.deleted", item: Diary.model_name.human), status: :see_other
   end

   private

  def diary_params
    params.require(:diary).permit(:title, :body, :diary_image, :diary_image_cache, :date, :weather, :emotion)
  end
end
