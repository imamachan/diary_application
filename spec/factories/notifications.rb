FactoryBot.define do
  factory :notification do
    association :user
    association :notifier, factory: :user
    association :diary
    action { "commented" }
    read { false }
  end
end
