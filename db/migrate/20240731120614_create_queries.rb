class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.string :customer_name
      t.string :customer_email
      t.text :message
      t.timestamps
    end
  end
end
