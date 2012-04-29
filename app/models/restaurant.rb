class Restaurant < ActiveRecord::Base
  has_many :posts
  mount_uploader :image, RestaurantUploader

  def calculate_rating(rating)
    current_rating = self.rating
    if current_rating == 0
      new_rating = current_rating + rating 
    else 
      new_rating = (current_rating + rating) / 2
    end
    self.rating = new_rating
  end
end
