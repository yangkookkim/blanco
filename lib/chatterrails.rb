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

  def self.update_status(client, user_id, text)
    result = Databasedotcom::Chatter::UserProfileFeed.post(client, user_id, :text => text)
  end

  def self.update_groupstatus(client, group_id, text)
    puts group_id
    result = Databasedotcom::Chatter::RecordFeed.post(client, group_id, :text => text)
  end

  # You can get almost the same information with NewsFeed and UserProfileFeed for your account.
  # Howerver, you cannot get other people's NewsFeed.
  def get_news_feed(client, id)
    nf = Databasedotcom::Chatter::NewsFeed.find(client, id)
  end

  def get_user_profile_feed(client, id)
    nf = Databasedotcom::Chatter::UserProfileFeed.find(client, id)
  end

  def get_group_feeditems(client, id)
    gf = Databasedotcom::Chatter::RecordFeed.find(client, id)
  end

  # Returns array where each elemet is a hash. The has has following keys.
  # :feeditem is a feeditem ruby object
  # :parent is the post which starts the feed
  # :comment is the array of comments for parent post.
  def all_feeds_of(client, id)
    news_feeds = self.get_user_profile_feed(client, id)
    posts = []
    news_feeds.each do |n|
      post = {:feeditem =>n, :parent => n.raw_hash, :comments => n.comments}
      posts << post
    end
    posts
  end

  # This has to be included in all_feeds_of() TBD
  def all_groupfeeds_of(client, id)
    news_feeds = self.get_group_feeditems(client, id)
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

