require 'chatterprofile'
class ChatterprofilesController < ApplicationController
  layout "profile_chatterprofile"
  before_filter :sfdc_authenticate
  def show
    #@profile = Profile.find(params[:id])
    @profile = Profile.find(params[:profile_id])
    @employee = @profile.employee
    @feeds = []

    cp = Chatterprofile.new()
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
