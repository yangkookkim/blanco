require 'databasedotcom'
require 'databasedotcom/chatter'
require 'chatterprofile'
class SessionsController < ApplicationController
  def create
    employee = Employee.authenticate(params[:username], params[:passwd])  
    if employee
      session[:user_id] = employee.id
      redirect_to :action => 'show', :controller => 'employees', :id => employee.id
    else  
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end
  end

  def sfdc_login
    unless session[:sfdc_client]
      session[:sfdc_access_token] = request.env['omniauth.auth']['credentials']['token']
      session[:sfdc_instance_url] = request.env['omniauth.auth']['credentials'].instance_url
      client = Databasedotcom::Client.new(:client_id => "3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X", :client_secret => "2647515227667638785")
      client.authenticate :token => session[:sfdc_access_token], :instance_url => session[:sfdc_instance_url]
      session[:sfdc_client] = client
    end

    cp = Chatterprofile.new()
    posts = cp.all_feeds_of(session[:sfdc_client], "me")
    texts = []
    posts.each do |p|
      txt = p[:parent]["body"]["text"]
      texts << txt.to_ue
    end
    render :text => texts
  end
end
