class Profile < ActiveRecord::Base
  belongs_to :employee
  has_one :chatterprofile
end
