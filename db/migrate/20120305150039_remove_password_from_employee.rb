class RemovePasswordFromEmployee < ActiveRecord::Migration
  def up
    remove_column :employees, :password
  end

  def down
    add_column :employees, :password, :string
  end
end
