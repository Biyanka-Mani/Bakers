class AddActiveToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :active, :boolean, default: true
  end
end
