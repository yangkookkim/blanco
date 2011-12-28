class Tag < ActiveRecord::Base
  has_many :employee_tags
  has_many :employees, :through => :employee_tags
end
