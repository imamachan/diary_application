require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:diary) { create(:diary) }

  before { login(user) }

  describe "POST /diaries/:diary_id/comments" do
    it "コメントを投稿できる" do
      comment_params = { comment: { body: "これはテストコメントです。" } }
      expect {
        post diary_comments_path(diary), params: comment_params
      }.to change(Comment, :count).by(1)
      expect(response).to redirect_to(diary_path(diary))
    end
  end

  describe "DELETE /comments/:id" do
    let!(:comment) { create(:comment, user: user, diary: diary) }

    it "コメントを削除できる" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)
    end
  end
end
