class AddIsVegetarianandIngredientsToProductsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_vegetarian, :boolean, default: false
    add_column :products, :ingredients, :text
  end
end
