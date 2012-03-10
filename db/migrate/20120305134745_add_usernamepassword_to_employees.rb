class AddUsernamepasswordToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :username, :string
    add_column :employees, :password_hash, :string
    add_column :employees, :password_salt, :string
  end
end
