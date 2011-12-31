class Group < ActiveRecord::Base
  has_many :employee_groups
  has_many :employees, :through => :employee_groups
  has_many :posts
end
