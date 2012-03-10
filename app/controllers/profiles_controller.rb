require 'chatterprofile'
class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @employee = @profile.employee
  end

  def new
  end

  def index
  end

end
