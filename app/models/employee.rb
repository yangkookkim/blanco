class Employee < ActiveRecord::Base
  has_many :employee_groups
  has_many :groups, :through => :employee_groups
  has_many :employee_tags
  has_many :tags, :through => :employee_tags
  has_many :posts
  has_one :profile
end
