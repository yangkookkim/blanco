require 'chatterrails'
class ChatterprofilesController < ApplicationController
  layout "profile_chatterprofile"
  before_filter :sfdc_authenticate
  def show
    @employee = Employee.find(params[:employee_id])
    @profile = @employee.profile
    @feeds = []

    cp = ChatterRails.new()
    posts = cp.all_feeds_of(session[:sfdc_client], params[:id])
    @feeds = []
    posts.each do |p|
      txt = p[:parent]["body"]["text"]
      @feeds << txt.to_ue
    end
  end

  def index
  end 

  private
  def sfdc_authenticate
    if session[:sfdc_client].nil?
      session[:redirect_to] = request.fullpath
      redirect_to '/auth/salesforce'
      return
    end  
  end
end
