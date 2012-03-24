require 'pp'
require 'chatterrails'

class ChatterprofilesController < ChatterfeedsController
  layout 'profile_chatterprofile', :except => [:post_feed_comment, :update_status, :delete_comment, :delete_feed]
  before_filter :sfdc_authenticate
  
  RESOURCE_TYPE="UserProfile"

  def show
    super
    fds = ChatterRails.all_feeds(session[:sfdc_client], params[:id], RESOURCE_TYPE)
    @feeds = unescape_feeds(fds)
    render 'chatterfeeds/show'
  end

  def update_status
    super
    result = ChatterRails.update_status(session[:sfdc_client], RESOURCE_TYPE, @resource_id, @text)
    @new_post = result.raw_hash
    render 'chatterfeeds/update_status'
  end

end
