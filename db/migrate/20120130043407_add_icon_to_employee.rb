class AddIconToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :icon, :string
  end
end
