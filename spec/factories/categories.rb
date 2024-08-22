FactoryBot.define do
  factory :category do
    name { "Category Name" }
    categoryimage { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/png') }
  end
end
