class ProfilesController < ApplicationController
  def show
    @employee = Employee.find(params[:employee_id])
    @profile = @employee.profile
    @chatterprofile = @profile.chatterprofile
  end

  def new
  end

  def index
  end

end
