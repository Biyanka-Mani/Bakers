
FactoryBot.define do
  factory :contact_info do
    phone { "123-456-7890" }
    email { "test@example.com" }
    address { "123 Test Street, Test City" }
    website { "https://www.example.com" }
    store_timings { "Mon-Fri: 9am - 5pm" }
  end
end

