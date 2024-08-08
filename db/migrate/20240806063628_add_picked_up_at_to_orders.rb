class AddPickedUpAtToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :picked_up_at, :datetime
  end
end
