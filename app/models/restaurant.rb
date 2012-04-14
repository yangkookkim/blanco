class Restaurant < ActiveRecord::Base
  mount_uploader :image, RestaurantUploader
end
