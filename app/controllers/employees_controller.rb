class EmployeesController < ApplicationController
  def home
    e = Employee.find(1)
    render :text => e.name
  end
end
