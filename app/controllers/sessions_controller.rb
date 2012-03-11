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

  def sfdc_client_auth
    session[:sfdc_access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:sfdc_instance_url] = request.env['omniauth.auth']['credentials'].instance_url
    client = Databasedotcom::Client.new(:client_id => ENV['sfdc_consumer_key'], :client_secret => ENV['sfdc_consumer_secret'])
    client.authenticate :token => session[:sfdc_access_token], :instance_url => session[:sfdc_instance_url]
    session[:sfdc_client] = client
    redirect_to session[:redirect_to] 
  end
end
