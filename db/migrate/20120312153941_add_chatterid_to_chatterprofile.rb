class AddChatteridToChatterprofile < ActiveRecord::Migration
  def change
    add_column :chatterprofiles, :chatterid, :string
  end
end
