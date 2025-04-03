FactoryBot.define do
  factory :notification do
    association :user
    association :notifier, factory: :user
    association :diary
    read { false }
  end
end
