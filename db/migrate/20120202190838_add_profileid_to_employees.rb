class AddProfileidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :profile_id, :integer
  end
end
