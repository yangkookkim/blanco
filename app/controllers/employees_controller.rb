class EmployeesController < ApplicationController
  layout 'employees_groups_posts'
  def show
    @employee = Employee.find(params[:id])
    @id = @employee.id
    @name = @employee.name
    @groups = @employee.groups
    @group = Group.find(1)
  end

end
