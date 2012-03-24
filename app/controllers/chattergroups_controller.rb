require 'pp'
require 'chatterrails'

class ChattergroupsController < ChatterfeedsController
  layout 'employees_chattergroups_groups_posts', :except => [:post_feed_comment, :update_status, :delete_comment, :delete_feed]
  before_filter :sfdc_authenticate
  
  def show
    super
    fds = ChatterRails.all_feeds(session[:sfdc_client], params[:id], @@resource_type)
    @feeds = unescape_feeds(fds)
  end

  def update_status
    super
    result = ChatterRails.update_status(session[:sfdc_client], @@resource_type, @resource_id, @text)
    @new_post = result.raw_hash
  end

end
