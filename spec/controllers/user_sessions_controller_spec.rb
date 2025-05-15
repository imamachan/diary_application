require "rails_helper"

RSpec.describe "UserSessions", type: :request do
  let(:user) { create(:user) }

  describe "GET /login" do
    it "ログインページの表示に成功すること" do
      get login_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    context "正しい情報を入力した場合" do
      it "ログインに成功し、日記一覧にリダイレクトすること" do
        post login_path, params: { email: user.email, password: "password123" }
        expect(response).to redirect_to(diaries_path)
      end
    end

    context "誤った情報を入力した場合" do
      it "ログインに失敗し、ログインページを再表示すること" do
        post login_path, params: { email: user.email, password: "wrong" }
        expect(response.body).to include(I18n.t("defaults.flash_messages.login_failed"))
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /logout" do
    let(:user) { create(:user) }

    before do
      post login_path, params: { email: user.email, password: "password123" }
    end
    it "ログアウト後にトップページへリダイレクトされること" do
      delete logout_path
      expect(response).to redirect_to(root_path)
    end
  end
end
