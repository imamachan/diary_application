class DiariesController < ApplicationController
  before_action :require_login
  
  def index
    @diaries = Diary.includes(:user)
  end
end
