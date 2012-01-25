class Post < ActiveRecord::Base
 belongs_to :employee
 belongs_to :group
 mount_uploader :image, PostUploader
end
