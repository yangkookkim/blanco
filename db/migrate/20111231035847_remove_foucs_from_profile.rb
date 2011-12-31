class RemoveFoucsFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :foucs
  end

  def down
    add_column :profiles, :foucs, :string
  end
end
