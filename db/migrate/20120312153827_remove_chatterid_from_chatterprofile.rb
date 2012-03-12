class RemoveChatteridFromChatterprofile < ActiveRecord::Migration
  def up
    remove_column :chatterprofiles, :chatter_id
  end

  def down
    add_column :chatterprofiles, :chatter_id, :string
  end
end
