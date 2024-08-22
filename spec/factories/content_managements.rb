FactoryBot.define do
  factory :content_management do
    home_page_category_header { "Delicious Cakes" }
    home_page_category_description { "Discover our wide variety of cakes, all baked fresh daily." }
    home_page_baking_header { "Baking with Love" }
    home_page_baking_description { "Our baking process is a labor of love, ensuring the best quality." }
    about_us_header { "About Our Bakery" }
    about_us_story { "Our story began in a small kitchen..." }
    master_baker_header { "Meet Our Master Baker" }
    master_baker_description { "Our master baker has over 20 years of experience." }
    baking_image { "baking.jpg" }
    master_baker_image { "baker.jpg" }
  end
end
