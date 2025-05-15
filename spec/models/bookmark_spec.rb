require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }
  let(:diary) { create(:diary, user: user) }
  let(:other_user) { create(:user) }

  describe "バリデーションのテスト" do
    it "ユーザーと日記があれば有効であること" do
      bookmark = build(:bookmark, user: other_user, diary: diary)
      expect(bookmark).to be_valid
    end

    it "同じユーザーが同じ日記を複数回ブックマークできないこと" do
      create(:bookmark, user: other_user, diary: diary)
      duplicate_bookmark = build(:bookmark, user: other_user, diary: diary)

      expect(duplicate_bookmark).to be_invalid
    end
  end
end
