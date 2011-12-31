class RemoveProfilefocusFromEmployee < ActiveRecord::Migration
  def up
    remove_column :employees, :profile_focus
  end

  def down
    add_column :employees, :profile_focus, :string
  end
end
