FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    confirmed_at { Time.current }  # Assuming confirmable module is used

    # Add any additional attributes here if needed
    # For example, if you have other attributes on the User model

    trait :with_products do
      after(:create) do |user|
        create_list(:product, 3, user: user)
      end
    end
  end
end

