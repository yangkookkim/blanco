class AddPortraitToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :portrait, :string
  end
end
