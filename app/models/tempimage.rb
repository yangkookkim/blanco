class Tempimage < ActiveRecord::Base
  mount_uploader :image, TempimageUploader
end
