require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "#reset_password_email" do
    let(:user) do
      create(:user, reset_password_token: "dummy_token")
    end

    let(:mail) { described_class.reset_password_email(user) }

    it "正しい件名で送信されること" do
      expect(mail.subject).to eq(I18n.t("defaults.password_reset"))
    end

    it "宛先が正しいこと" do
      expect(mail.to).to eq([ user.email ])
    end

    it "本文にパスワードリセットリンクが含まれていること" do
      expect(mail.text_part.body.decoded).to include("dummy_token")
    end
  end
end
