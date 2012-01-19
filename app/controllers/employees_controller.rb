class EmployeesController < ApplicationController
  layout 'employees_groups_posts'
  def show
    @employee = Employee.find(params[:id])
    @id = @employee.id
    @name = @employee.name
    @groups = @employee.groups
  end
end
