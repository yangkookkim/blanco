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

  # You can get almost the same information with NewsFeed and UserProfileFeed for your account.
  # Howerver, you cannot get other people's NewsFeed.
  def get_news_feed(client, id)
    nf = Databasedotcom::Chatter::NewsFeed.find(client, id)
  end

  def get_user_profile_feed(client, id)
    nf = Databasedotcom::Chatter::UserProfileFeed.find(client, id)
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
  
  def post_comment(client, parent_post_id, comment)
    feeditem = Databasedotcom::Chatter::FeedItem.find(client, "0D5d0000008nqC9CAI")
    feeditem.comment(comment)
  end

end

class String
  def to_ue
    CGI.unescapeHTML(self)
  end
end

