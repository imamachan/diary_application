require "rails_helper"

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification, user: user) }

  before do
    login(user)
  end

  describe "GET /notifications" do
    it "通知一覧が表示される" do
      get notifications_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("コメントしました")
    end
  end

  describe "PATCH /notifications/:id/mark_as_read" do
    it "通知が既読になる" do
      patch mark_as_read_notification_path(notification)
      expect(response).to redirect_to(diary_path(notification.diary))
      expect(notification.reload.read).to eq(true)
    end
  end

  describe "DELETE /notifications/:id" do
    it "通知が削除される" do
      expect {
        delete notification_path(notification)
      }.to change(Notification, :count).by(-1)
    end
  end
end
