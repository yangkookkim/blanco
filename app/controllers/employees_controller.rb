class EmployeesController < ApplicationController
  def show
    e = Employee.find(1)
    g = e.groups.find(1)
    p = g.posts.find(1)
    render :text => "a"
  end
end