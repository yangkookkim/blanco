class RemoveRatingFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :rating
  end

  def down
    add_column :posts, :rating, :integer
  end
end
