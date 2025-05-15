require "rails_helper"

RSpec.describe "Diaries", type: :request do
  let(:user) { create(:user) }
  let!(:public_diary) { create(:diary, is_public: true) }
  let!(:private_diary) { create(:diary, is_public: false, user: user) }

  before do
    login(user) # ヘルパーがなければ sessions 経由でログイン処理を書く必要あり
  end

  describe "GET /diaries" do
    it "公開日記が表示されること" do
      get diaries_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(public_diary.title)
    end
  end

  describe "GET /diaries/:id" do
    context "公開日記の場合" do
      it "表示されること" do
        get diary_path(public_diary)
        expect(response).to have_http_status(:ok)
      end
    end

    context "非公開日記で他人の日記の場合" do
      let(:other_user) { create(:user) }
      let(:other_private_diary) { create(:diary, is_public: false, user: other_user) }

      it "リダイレクトされること" do
        get diary_path(other_private_diary)
        expect(response).to redirect_to(diaries_path)
      end
    end
  end

  describe "POST /diaries" do
    it "日記が作成されること" do
      diary_params = attributes_for(:diary)
      post diaries_path, params: { diary: diary_params.merge(is_public: true) }
      expect(response).to redirect_to(diaries_path)
    end
  end

  describe "PATCH /diaries/:id" do
    let(:diary) { create(:diary, user: user) }

    it "日記が更新されること" do
      patch diary_path(diary), params: { diary: { title: "Updated Title", is_public: diary.is_public } }
      expect(diary.reload.title).to eq("Updated Title")
    end
  end

  describe "DELETE /diaries/:id" do
    let!(:diary) { create(:diary, user: user) }

    it "日記が削除されること" do
      expect {
        delete diary_path(diary)
      }.to change(Diary, :count).by(-1)
    end
  end
end
