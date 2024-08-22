FactoryBot.define do
  factory :order do
    customer_name { "John Doe" }
    customer_email { "john1.doe@example.com" }
    customer_phone { "+1234567890" }
    order_status { :confirmed } # or use a valid status like :processing
    

    # Optional: Create associated order_products
    trait :with_order_products do
      after(:create) do |order|
        create_list(:order_product, 3, order: order)
      end
    end
  end
end

