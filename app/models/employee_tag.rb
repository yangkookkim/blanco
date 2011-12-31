class EmployeeTag < ActiveRecord::Base
  belongs_to :employee
  belongs_to :tag
end
