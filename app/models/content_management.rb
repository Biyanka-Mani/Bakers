class ContentManagement < ApplicationRecord
 
  validates :home_page_category_header, presence: true, length: { maximum: 255 }
  validates :home_page_category_description, presence: true, length: { maximum: 1000 }
  validates :home_page_baking_header, presence: true, length: { maximum: 255 }
  validates :home_page_baking_description, presence: true, length: { maximum: 1000 }
  validates :about_us_header, presence: true, length: { maximum: 255 }
  validates :about_us_story, presence: true, length: { maximum: 1000 }
  validates :master_baker_header, presence: true, length: { maximum: 255 }
  validates :master_baker_description, presence: true, length: { maximum: 1000 }


  validates :baking_image, format: { with: /\A.*\.(jpg|jpeg|png)\z/i, message: "must be a JPG, JPEG, or PNG" }
  validates :master_baker_image, format: { with: /\A.*\.(jpg|jpeg|png)\z/i, message: "must be a JPG, JPEG, or PNG" }
end

