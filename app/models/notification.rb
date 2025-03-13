class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifier, class_name: "User", foreign_key: "notifier_id", optional: true
  belongs_to :diary

  scope :unread, -> { where(read: false) }
end
