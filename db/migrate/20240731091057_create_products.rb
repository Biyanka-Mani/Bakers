class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name 
      t.text :description 
      t.integer :category_id
      t.decimal :unit_price
      t.integer :stock_quantity
      t.timestamps
    end
  end
end
