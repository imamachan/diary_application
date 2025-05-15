require "rails_helper"

RSpec.describe "Oauths", type: :request do
  describe "GET /oauth/:provider" do
    it "プロバイダーにリダイレクトする" do
      get auth_at_provider_path(provider: "google")
      expect(response).to have_http_status(:found) # 302 リダイレクト
    end
  end

  describe "GET /oauth/callback" do
    it "ログインに失敗してrootにリダイレクトされる" do
      allow_any_instance_of(OauthsController).to receive(:login_from).and_return(nil)
      allow_any_instance_of(OauthsController).to receive(:create_from).and_raise(StandardError)

      get oauth_callback_path(provider: "google")
      expect(response).to redirect_to(root_path)
    end
  end
end
