class Diary < ApplicationRecord
  belongs_to :user
  mount_uploader :diary_image, DiaryImageUploader
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
