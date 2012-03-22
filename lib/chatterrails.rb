require 'pp'
require 'cgi'
require 'databasedotcom'
require 'databasedotcom/chatter'

module Chatterhelper
  def comments_from_feeditem(feeditem)
    comments = []
    feeditem.comments.each do |c|
      comments << c["body"]["text"]
    end
    comments
  end

  def body_from_feeditem(feeditem)
    feeditem.raw_hash["body"]
  end
end

include Chatterhelper
class ChatterRails < Databasedotcom::Chatter::Group
  def initialize()
  end

  def self.update_status(client, resource_type, user_id, text)
    case resource_type
    when "Group" then
      result = Databasedotcom::Chatter::RecordFeed.post(client, user_id, :text => text)
    when "UserProfile" then
      result = Databasedotcom::Chatter::UserProfileFeed.post(client, user_id, :text => text)
    else
      puts "unknown resource" 
    end
  end

  def get_feeditems(client, id, resource_type)
    case resource_type
    when "Group"
      Databasedotcom::Chatter::RecordFeed.find(client, id)
    when "UserProfile"
      Databasedotcom::Chatter::UserProfileFeed.find(client, id)
    else
      raise "Unknown resource_type"
    end
  end

  # Returns array where each elemet is a hash. The has has following keys.
  # :feeditem is a feeditem ruby object
  # :parent is the post which starts the feed
  # :comment is the array of comments for parent post.
  def all_feeds(client, id, resource_type)
    news_feeds = self.get_feeditems(client, id, resource_type)
    posts = []
    news_feeds.each do |n|
      post = {:feeditem =>n, :parent => n.raw_hash, :comments => n.comments}
      posts << post
    end
    posts
  end

  def post_comment(client, parent_post_id, comment)
    feeditem = Databasedotcom::Chatter::FeedItem.find(client, parent_post_id)
    feeditem.comment(comment)
  end

  def post_groupcomment(client, parent_post_id, comment)
    feeditem = Databasedotcom::Chatter::Record.find(client, parent_post_id)
    feeditem.comment(comment)
  end

  def self.delete_comment(client, comment_id)
    result = Databasedotcom::Chatter::Comment.delete(client, comment_id)
  end

  def self.delete_feed(client, feed_id)
    result = Databasedotcom::Chatter::FeedItem.delete(client, feed_id)
  end
end

class String
  def to_ue
    CGI.unescapeHTML(self)
  end
end

