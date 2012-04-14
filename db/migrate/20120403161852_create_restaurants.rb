class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :rcd
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :image

      t.timestamps
    end
  end
end
