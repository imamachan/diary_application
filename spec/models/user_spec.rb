require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let(:user) { build(:user) }

    context "名前がある場合" do
      it { is_expected.to be true }
    end

    context "名前が空の場合" do
      before { user.name = "" }
      it { is_expected.to be false }
    end

    context "メールアドレスが正しい形式の場合" do
      it { is_expected.to be true }
    end

    context "メールアドレスが空の場合" do
      before { user.email = "" }
      it { is_expected.to be false }
    end

    context "メールアドレスが重複する場合" do
      before do
        create(:user, email: user.email)
      end
      it { is_expected.to be false }
    end

    context "パスワードが3文字以上の場合" do
      it { is_expected.to be true }
    end

    context "パスワードが2文字以下の場合" do
      before { user.password = "ab" }
      it { is_expected.to be false }
    end

    context "Google認証時（パスワードなし）" do
      let(:user) { build(:user, password: nil, password_confirmation: nil) }
      before { user.authentications.build(provider: "google", uid: "1234567890") }

      it { is_expected.to be true }
    end
  end
end
