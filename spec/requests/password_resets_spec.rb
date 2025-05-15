require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  let!(:user) { create(:user) }

  describe "GET /password_resets/new" do
    it "新しいリセットリクエストフォームが表示されること" do
      get new_password_reset_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("パスワードリセット申請")
    end
  end

  describe "POST /password_resets" do
    it "存在するメールアドレスで送信成功すること" do
      post password_resets_path, params: { email: user.email }
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response.body).to include("パスワードリセット手順を送信しました")
    end
  end

  describe "GET /password_resets/:token/edit" do
    it "トークンが正しい場合、編集フォームが表示されること" do
      user.deliver_reset_password_instructions!
      get edit_password_reset_path(user.reset_password_token)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("パスワード")
    end
  end

  describe "PATCH /password_resets/:token" do
    it "正しくパスワードが変更され、ログインページへリダイレクトされること" do
      user.deliver_reset_password_instructions!
      patch password_reset_path(user.reset_password_token), params: {
        user: {
          password: "newpassword",
          password_confirmation: "newpassword"
        }
      }
      expect(response).to redirect_to(login_path)
    end
  end
end
