class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }
  after_create :create_notification

  belongs_to :user
  belongs_to :diary

  private

  def create_notification
    return if diary.user == user

    Notification.create!(
      user: diary.user,
      notifier: user,
      diary: diary,
      action: "commented"
    )
  end
end
