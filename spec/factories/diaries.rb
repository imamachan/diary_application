FactoryBot.define do
  factory :diary do
    association :user  # ユーザーとの関連を設定
    title { "日記のタイトル" }
    body { "これはテスト用の日記の本文です。" }
  end
end
