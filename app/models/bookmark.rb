class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :diary
  after_create :create_notification

  validates :user_id, uniqueness: { scope: :diary_id }

  private

  def create_notification
    return if diary.user == user

    Notification.create!(
      user: diary.user,
      notifier: user,
      diary: diary,
      action: "bookmarked"
    )
  end
end
