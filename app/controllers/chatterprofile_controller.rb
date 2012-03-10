require 'chatterprofile'
class ChatterprofileController < ApplicationController
  layout "profile_chatterprofile"
  def show
    @profile = Profile.find(params[:id])
    @employee = @profile.employee
    @feeds = []
    client = Databasedotcom::Client.new(:client_id => "3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X", :client_secret => "2647515227667638785")
    client.authenticate :token => session[:sfdc_access_token], :instance_url => session[:sfdc_instance_url]
    mycomments = Chatterprofile.get_my_comments(client)
    puts mycomments
  end

  def index
  end
end
