class RemoveProfileIdFromEmployees < ActiveRecord::Migration
  def up
    remove_column :employees, :profile_id
  end

  def down
    add_column :employees, :profile_id, :integer
  end
end
