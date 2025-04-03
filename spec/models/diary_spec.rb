require 'rails_helper'

RSpec.describe Diary, type: :model do
  let(:user) { create(:user) }
  let(:diary) { build(:diary, user: user) }

  describe "バリデーションのテスト" do
    it "有効な日記が作成できること" do
      expect(diary).to be_valid
    end

    it "タイトルがないと無効であること" do
      diary.title = nil
      expect(diary).to be_invalid
    end

    it "本文がないと無効であること" do
      diary.body = nil
      expect(diary).to be_invalid
    end

    it "タイトルが255文字以内であること" do
      diary.title = "a" * 255
      expect(diary).to be_valid

      diary.title = "a" * 256
      expect(diary).to be_invalid
    end

    it "本文が65535文字以内であること" do
      diary.body = "a" * 65_535
      expect(diary).to be_valid

      diary.body = "a" * 65_536
      expect(diary).to be_invalid
    end
  end
end
