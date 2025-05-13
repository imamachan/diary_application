require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { User.create(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password") }
  let(:notifier) { User.create(name: "Notifier", email: "notifier@example.com", password: "password", password_confirmation: "password") }
  let(:diary) { Diary.create(user: user, title: "Test Diary", body: "This is a test diary entry.") }
  let(:notification) { Notification.create(user: user, notifier: notifier, diary: diary, read: false) }


  describe "バリデーション" do
    it "ユーザー、通知者、日記があれば有効である" do
      notification = build(:notification)
      expect(notification).to be_valid
    end

    it "ユーザーがなければ無効である" do
      notification = build(:notification, user: nil)
      expect(notification).to be_invalid
    end

    it "日記がなければ無効である" do
      notification = build(:notification, diary: nil)
      expect(notification).to be_invalid
    end
  end

  describe "アソシエーション" do
    it "user に属している" do
      expect(notification.user).to eq(user)
    end

    it "notifier に属している" do
      expect(notification.notifier).to eq(notifier)
    end

    it "diary に属している" do
      expect(notification.diary).to eq(diary)
    end
  end

  describe "スコープ" do
    it "未読の通知を取得できること" do
      unread_notification = Notification.create(user: user, notifier: notifier, diary: diary, read: false)
      read_notification = Notification.create(user: user, notifier: notifier, diary: diary, read: true)

      expect(Notification.unread).to include(unread_notification)
      expect(Notification.unread).not_to include(read_notification)
    end
  end
end
