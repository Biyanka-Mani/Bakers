FactoryBot.define do
  factory :order_product do
    order
    product
    quantity { 1 }
  end
end
