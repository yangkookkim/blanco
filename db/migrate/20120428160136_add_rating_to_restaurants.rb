class AddRatingToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :rating, :integer, :default => 0
  end
end
