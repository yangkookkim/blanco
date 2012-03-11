class AddChatteridToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :chatterid, :string
  end
end
