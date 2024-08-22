# spec/factories/contact_us_requests.rb

FactoryBot.define do
  factory :contact_us_request do
    customer_name { "John Doe" }
    customer_email { "john.doe@example.com" }
    message { "This is a sample message for testing purposes." }
  end
end
