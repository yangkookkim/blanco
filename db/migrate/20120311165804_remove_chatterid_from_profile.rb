class RemoveChatteridFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :chatterid
  end

  def down
    add_column :profiles, :chatterid, :string
  end
end
