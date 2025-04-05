require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  before do
    post login_path, params: { email: user.email, password: "password123" }
  end

  describe "GET /profile" do
    it "プロフィール表示ページにアクセスできること" do
      get profile_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.name)
    end
  end

  describe "GET /profile/edit" do
    it "編集ページが表示されること" do
      get edit_profile_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("プロフィール編集")
    end
  end

  describe "PATCH /profile" do
    it "プロフィールが更新されること" do
      patch profile_path, params: {
        user: {
          name: "名前",
          profile_comment: "更新されたコメント"
        }
      }
      expect(response).to redirect_to(profile_path)
      follow_redirect!
      expect(response.body).to include("名前")
    end
  end
end
