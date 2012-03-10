class RemoveUsernamepasswordFromEmployees < ActiveRecord::Migration
  def up
    remove_column :employees, :username
    remove_column :employees, :password_hash
    remove_column :employees, :password_salt
  end

  def down
    add_column :employees, :password_salt, :string
    add_column :employees, :password_hash, :string
    add_column :employees, :username, :string
  end
end
