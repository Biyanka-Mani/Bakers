class RenameQueriesTableToContactUsRequestTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :queries, :contact_us_requests
  end
end
