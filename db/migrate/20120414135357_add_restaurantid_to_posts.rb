class AddRestaurantidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :restaurant_id, :integer
  end
end
