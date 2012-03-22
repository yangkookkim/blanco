require 'pp'
require 'chatterrails'

class ChatterfeedsController < ApplicationController
  layout 'employees_chattergroups_groups_posts', :except => [:post_feed_comment, :update_status, :delete_comment, :delete_feed]
  before_filter :sfdc_authenticate
  
  @@resource_type = nil

  def show
    @employee = Employee.find_by_id(params[:employee_id])
    @group = Group.find_by_id(params[:id])
    @groups = @employee.groups
    @profile = @employee.profile
    cr = ChatterRails.new()
    resource_id = params[:id]
    set_resource_type(resource_id)
    
    fds = cr.all_feeds(session[:sfdc_client], params[:id], @@resource_type)
    @feeds = unescape_feeds(fds)
  end

  def show_js
    @resource_id = params[:id].sub(/.js$/, "")
    set_resource_type(@resource_id)

    @employee = Employee.find(params[:employee_id])
    respond_to do |format|
      format.js   {render :layout => false}
    end
  end

  def update_status
    resource_id = params[:resource_id].sub(/.js$/, "")
    set_resource_type(resource_id)

    group_id = params[:group_id]
    resource_id = params[:resource_id]
    text = params[:text]
    result = ChatterRails.update_status(session[:sfdc_client], @@resource_type, resource_id, text)
    @new_post = result.raw_hash
  end

  def post_feed_comment
    employee_id = params[:employee_id]
    feed_id = params[:feed_id]
    feed_comment = params[:feed_comment]
    cp = ChatterRails.new()
    result = cp.post_comment(session[:sfdc_client], feed_id, feed_comment)
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
 
  def set_resource_type(resource_id)
    group_expr = /0F9/
    userprofile_expr = /005/
    if resource_id.slice(0,3) =~ group_expr 
      @@resource_type = "Group"
    elsif resource_id.slice(0,3) =~ userprofile_expr 
      @@resource_type = "UserProfile"
    else
      @@resource_type = nil
    end
  end
end
