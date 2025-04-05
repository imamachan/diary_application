require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    context "有効なパラメータの場合" do
      let(:valid_params) { { user: { name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password" } } }

      it "ユーザーが作成されること" do
        expect {
          post users_path, params: valid_params
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) { { user: { name: "", email: "invalid_email", password: "pass", password_confirmation: "word" } } }

      it "ユーザーが作成されないこと" do
        expect {
          post users_path, params: invalid_params
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("名前は必須項目です")
        expect(response.body).to include("メールアドレスは正しい形式で入力してください")
        expect(response.body).to include("パスワード確認とパスワードの入力が一致しません")
      end
    end
  end
end
