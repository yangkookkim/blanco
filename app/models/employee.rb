class Employee < ActiveRecord::Base
  attr_accessor :password
  has_many :employee_groups
  has_many :groups, :through => :employee_groups
  has_many :employee_tags
  has_many :tags, :through => :employee_tags
  has_many :posts
  has_one :profile
  mount_uploader :icon, EmployeeUploader

  def self.authenticate(username, password)  
      employee = find_by_username(username)  
      if username && employee.passwd == password
        employee
      else  
        nil  
      end  
  end
end
