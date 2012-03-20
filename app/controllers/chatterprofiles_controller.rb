require 'pp'
require 'chatterrails'
class ChatterprofilesController < ApplicationController
  layout "profile_chatterprofile", :except => [:post_feed_comment, :update_status, :delete_comment, :delete_feed]
  before_filter :sfdc_authenticate
  def show
    @employee = Employee.find(params[:employee_id])
    @profile = @employee.profile
    @feeds = []

    cp = ChatterRails.new()
    fds = cp.all_feeds_of(session[:sfdc_client], params[:id])
    @feeds = unescape_feeds(fds)
  end

  def update_status
    employee_id = params[:employee_id]
    text = params[:text]
    @employee = Employee.find(employee_id)
    @profile = @employee.profile
    result = ChatterRails.update_status(session[:sfdc_client], @profile.chatterprofile.chatterid, text)
    @new_post = result.raw_hash
  end

  def post_feed_comment
    employee_id = params[:employee_id]
    feed_id = params[:feed_id]
    feed_comment = params[:feed_comment]
    @employee = Employee.find(employee_id)
    @profile = @employee.profile
    cp = ChatterRails.new()
    result = cp.post_comment(session[:sfdc_client], feed_id, feed_comment)
    @new_comment = result.raw_hash
  end

  def delete_comment
    comment_id = params[:comment_id]
    @result = ChatterRails.delete_comment(session[:sfdc_client], comment_id)
  end

  def delete_feed
    feed_id = params[:feed_id]
    @result = ChatterRails.delete_feed(session[:sfdc_client], feed_id)
  end

  def show_js
    @employee = Employee.find(params[:employee_id])
    respond_to do |format|
      format.js   {render :layout => false}
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

  def unescape_feeds(feeds)
    if feeds.is_a?(Array)
      feeds.each do |feed|
        feed[:parent]["body"]["text"] = feed[:parent]["body"]["text"].to_ue
        feed[:comments].each do |comment|
          comment["body"]["text"] = comment["body"]["text"].to_ue
        end
      end
    else
      raise "Wrong argument type. Must be array"
    end
    feeds
  end
  
end
