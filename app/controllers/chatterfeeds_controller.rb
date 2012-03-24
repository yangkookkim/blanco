require 'pp'
require 'chatterrails'

# ChatterfeedsController is the superclass of ChattergroupsController and ChatterprofileController.
# Actions defined in ChatterfeedsController is not directly called, but called from subclass.
class ChatterfeedsController < ApplicationController
  
  RESOURCE_TYPE= %w(Groups UserProfile)
  
  def show
    @employee = Employee.find_by_id(params[:employee_id])
    @group = Group.find_by_id(params[:id])
    @groups = @employee.groups
    @profile = @employee.profile
    @resource_id = params[:id]
  end

  def update_status
    @resource_id = params[:resource_id].sub(/.js$/, "")
    @group_id = params[:group_id]
    @resource_id = params[:resource_id]
    @text = params[:text]
  end

  def show_js
    @resource_id = params[:id].sub(/.js$/, "")
    @employee = Employee.find(params[:employee_id])
    respond_to do |format|
      format.js   {render :layout => false}
    end
  end
  
  def post_feed_comment
    employee_id = params[:employee_id]
    feed_id = params[:feed_id]
    feed_comment = params[:feed_comment]
    result = ChatterRails.post_comment(session[:sfdc_client], feed_id, feed_comment)
    @new_comment = result.raw_hash
    pp @new_comment
  end

  def delete_comment
    comment_id = params[:comment_id]
    @result = ChatterRails.delete_comment(session[:sfdc_client], comment_id)
  end

  def delete_feed
    feed_id = params[:feed_id]
    @result = ChatterRails.delete_feed(session[:sfdc_client], feed_id)
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
