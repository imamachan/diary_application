class Diary < ApplicationRecord
  belongs_to :user
  mount_uploader :diary_image, DiaryImageUploader

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
