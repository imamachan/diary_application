FactoryBot.define do
  factory :comment do
    association :user
    association :diary
    body { "これはテスト用のコメントです。" }
  end
end
