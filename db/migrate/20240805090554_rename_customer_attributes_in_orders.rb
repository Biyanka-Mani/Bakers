class RenameCustomerAttributesInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :Customer_name, :customer_name
    rename_column :orders, :Customer_phone, :customer_phone
    rename_column :orders, :Customer_email, :customer_email
  end
end
