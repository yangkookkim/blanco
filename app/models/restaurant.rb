class Restaurant < ActiveRecord::Base
  has_many :posts
  mount_uploader :image, RestaurantUploader
end
