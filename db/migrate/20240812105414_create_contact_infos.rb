class CreateContactInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_infos do |t|
      t.string :phone
      t.string :email
      t.text :address
      t.string :website
      t.string :store_timings

      t.timestamps
    end
  end
end
