FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    description { "This is a sample product description with sufficient length for testing purposes. It should be at least 50 characters long." }
    unit_price { 10.0 }
    is_vegetarian { true }
    ingredients { "Sample ingredients for testing purposes." }
    storage_instructions { "Keep in a cool, dry place." }
    stock_quantity { 10 }
    active { true }
    association :category
    association :user 

    trait :with_images do
      after(:create) do |product|
        product.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')), filename: 'image.jpg', content_type: 'image/jpg')
      end
    end
  end
end

