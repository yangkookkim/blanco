class AddUsernamesimplepasswordToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :username, :string
    add_column :employees, :password, :string
  end
end
