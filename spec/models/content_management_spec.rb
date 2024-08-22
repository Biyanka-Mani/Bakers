# spec/models/content_management_spec.rb

require 'rails_helper'

RSpec.describe ContentManagement, type: :model do
  it { should validate_presence_of(:home_page_category_header) }
  it { should validate_length_of(:home_page_category_header).is_at_most(255) }

  it { should validate_presence_of(:home_page_category_description) }
  it { should validate_length_of(:home_page_category_description).is_at_most(1000) }

  it { should validate_presence_of(:home_page_baking_header) }
  it { should validate_length_of(:home_page_baking_header).is_at_most(255) }

  it { should validate_presence_of(:home_page_baking_description) }
  it { should validate_length_of(:home_page_baking_description).is_at_most(1000) }

  it { should validate_presence_of(:about_us_header) }
  it { should validate_length_of(:about_us_header).is_at_most(255) }

  it { should validate_presence_of(:about_us_story) }
  it { should validate_length_of(:about_us_story).is_at_most(1000) }

  it { should validate_presence_of(:master_baker_header) }
  it { should validate_length_of(:master_baker_header).is_at_most(255) }

  it { should validate_presence_of(:master_baker_description) }
  it { should validate_length_of(:master_baker_description).is_at_most(1000) }

  it { should allow_value("image.jpg").for(:baking_image) }
  it { should allow_value("image.jpeg").for(:baking_image) }
  it { should allow_value("image.png").for(:baking_image) }
  it { should_not allow_value("image.gif").for(:baking_image).with_message("must be a JPG, JPEG, or PNG") }

  it { should allow_value("image.jpg").for(:master_baker_image) }
  it { should allow_value("image.jpeg").for(:master_baker_image) }
  it { should allow_value("image.png").for(:master_baker_image) }
  it { should_not allow_value("image.gif").for(:master_baker_image).with_message("must be a JPG, JPEG, or PNG") }
end
