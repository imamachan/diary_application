# spec/requests/require_login_spec.rb
require "rails_helper"

RSpec.describe "Authentication required", type: :request do
  it "未ログインユーザーは /diaries にアクセスできない" do
    get diaries_path
    expect(response).to redirect_to(login_path)
    follow_redirect!
    expect(response.body).to include("ログインしてください")
  end
end
