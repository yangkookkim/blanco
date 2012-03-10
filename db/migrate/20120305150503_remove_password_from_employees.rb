class RemovePasswordFromEmployees < ActiveRecord::Migration
  def up
    remove_column :employees, :password_hash
    remove_column :employees, :password_salt
  end

  def down
    add_column :employees, :password_salt, :string
    add_column :employees, :password_hash, :string
  end
end
