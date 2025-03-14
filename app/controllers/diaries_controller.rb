class DiariesController < ApplicationController
  before_action :require_login

  def index
    @q = Diary.where(is_public: true).ransack(params[:q])
    @diaries = @q.result(distinct: true).order(created_at: :desc)

    if params[:q].present?
      params[:q][:created_at_gteq] = params[:q][:created_at_gteq].to_date.beginning_of_day rescue nil
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day rescue nil
    end
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    @diary.is_public = ActiveModel::Type::Boolean.new.cast(params[:diary][:is_public])
    if @diary.save
      redirect_to diaries_path, success: "日記が投稿されました"
    else
      render :new, status: :unprocessable_entity, danger: "日記の投稿に失敗しました"
    end
  end

  def show
    @diary = Diary.find(params[:id])

    if !@diary.is_public && @diary.user != current_user
      redirect_to diaries_path, alert: "この日記は非公開です。"
    end

    @comment = Comment.new
    @comments = @diary.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    @diary = current_user.diaries.find(params[:id])
    @diary.is_public = ActiveModel::Type::Boolean.new.cast(params[:diary][:is_public])
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

  def bookmarks
    @bookmark_diaries = current_user.bookmark_diaries.includes(:user).order(created_at: :desc)
  end

  def mypage
    @diaries = current_user.diaries.where(is_public: true).order(created_at: :desc)
  end

  def private_mypage
    @diaries = current_user.diaries.where(is_public: false).order(created_at: :desc)
  end

  def calendar
    @diaries = current_user.diaries
  end

  def on_date
    date = Date.parse(params[:date])
    @diaries = current_user.diaries.where(date: date)
  end
   private

  def diary_params
    params.require(:diary).permit(:title, :body, :diary_image, :diary_image_cache, :date, :weather, :emotion, :is_public)
  end
end
