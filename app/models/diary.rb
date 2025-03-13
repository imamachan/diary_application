class Diary < ApplicationRecord
  belongs_to :user
  mount_uploader :diary_image, DiaryImageUploader
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "body", "date", "weather", "emotion", "created_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "bookmarks", "comments" ]
  end
end
