class CreateContentManagements < ActiveRecord::Migration[7.1]
  def change
    create_table :content_managements do |t|
      t.string :home_page_category_header
      t.text :home_page_category_description
      t.string :home_page_baking_header
      t.text :home_page_baking_description
      t.string :baking_image
      
      t.string :about_us_header
      t.text :about_us_story
      t.string :master_baker_header
      t.text :master_baker_description
      t.string :master_baker_image
      t.timestamps
    end
  end
end
