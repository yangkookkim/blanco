class RemoveSalesforcetokenFromSessions < ActiveRecord::Migration
  def up
    remove_column :sessions, :sfdc_access_token
  end

  def down
    add_column :sessions, :sfdc_access_token, :string
  end
end
