class AddSalesforcetokenToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :sfdc_access_token, :string
  end
end
