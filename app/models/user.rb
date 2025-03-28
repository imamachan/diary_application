class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :profile_picture, ProfilePictureUploader
  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_diaries, through: :bookmarks, source: :diary
  has_many :notifications, dependent: :destroy
  has_many :authentications, dependent: :destroy
    accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false, message: "はすでに登録されています" }
  validates :profile_comment, length: { maximum: 30 }, allow_blank: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validate :skip_password_validation_for_google, on: :create

  def own?(object)
    id == object&.user_id
  end

  def bookmark(diary)
  bookmark_diaries << diary
end

def unbookmark(diary)
  bookmark_diaries.destroy(diary)
end

def bookmark?(diary)
  bookmark_diaries.include?(diary)
end

 private

  def skip_password_validation_for_google
    # Google認証のためのユーザー作成時にパスワードバリデーションをスキップ
    if authentications.any? { |auth| auth.provider == "google" }
      errors.delete(:password)
      errors.delete(:password_confirmation)
    end
  end
end
