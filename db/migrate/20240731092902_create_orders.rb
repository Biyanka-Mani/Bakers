class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :Customer_name
      t.string :Customer_phone
      t.string :Customer_email
      t.boolean :is_picked 
      t.string :payment_transcation_id
      t.decimal :total_amount
      
      t.timestamps
    end
  end
end
