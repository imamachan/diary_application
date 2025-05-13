require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:diary) { create(:diary, user: user) }
  let(:other_user) { create(:user) }

  describe "バリデーションのテスト" do
    it "本文があれば有効であること" do
      comment = build(:comment, user: other_user, diary: diary)
      expect(comment).to be_valid
    end

    it "本文がないと無効であること" do
      comment = build(:comment, user: other_user, diary: diary, body: nil)
      expect(comment).to be_invalid
    end

    it "本文が65535文字以内であること" do
      comment = build(:comment, user: other_user, diary: diary, body: "a" * 65_535)
      expect(comment).to be_valid

      comment.body = "a" * 65_536
      expect(comment).to be_invalid
    end
  end
end
