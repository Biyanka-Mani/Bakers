class UpdateOrdersTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :payment_transcation_id, :string
    remove_column :orders, :is_picked, :boolean
    add_column :orders, :order_status, :integer, default: 0, null: false
  end
end
