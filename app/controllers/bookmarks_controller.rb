class BookmarksController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    current_user.bookmark(@diary)
  end

  def destroy
    @diary = current_user.bookmarks.find(params[:id]).diary
    current_user.unbookmark(@diary)
  end
end
