class AddStorageInstructionsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :storage_instructions, :text
  end
end
