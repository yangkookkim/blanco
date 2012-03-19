class AddChattergroupToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :ischattergroup, :boolean
    add_column :groups, :chattergroup_id, :integer
  end
end
