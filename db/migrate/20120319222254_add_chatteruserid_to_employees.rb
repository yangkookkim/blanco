class AddChatteruseridToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :chatteruserid, :integer
  end
end
