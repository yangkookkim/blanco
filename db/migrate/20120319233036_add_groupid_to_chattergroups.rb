class AddGroupidToChattergroups < ActiveRecord::Migration
  def change
    add_column :chattergroups, :group_id, :integer
  end
end
