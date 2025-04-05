require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  let(:user) { create(:user) }
  let(:diary) { create(:diary) }

  before do
    login(user)
  end

  describe "POST /diaries/:diary_id/bookmarks" do
    it "ブックマークを作成できる" do
      expect {
      post bookmarks_path, params: { diary_id: diary.id }
      }.to change(Bookmark, :count).by(1)
      expect(response).to redirect_to(diary_path(diary))
    end
  end

  describe "DELETE /bookmarks/:id" do
    let!(:bookmark) { create(:bookmark, user: user, diary: diary) }

    it "ブックマークを削除できる" do
      expect {
        delete bookmark_path(bookmark)
      }.to change(Bookmark, :count).by(-1)
    end
  end
end
