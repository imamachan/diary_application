FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    trait :with_google_auth do
      after(:create) do |user|
        user.authentications.create(provider: "google", uid: "1234567890" )
      end
    end
  end
end