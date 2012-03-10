require 'pp'
require 'cgi'
require 'databasedotcom'
require 'databasedotcom/chatter'
class Chatterprofile < Databasedotcom::Chatter::Group
  #def initialize(token, instance_url)
  #  @client = Databasedotcom::Client.new(:client_id => "3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X", :client_secret => "2647515227667638785")
  #  @client.authenticate :token => token, :instance_url => instance_url
  #end
  def initialize()
  end

  def get_news_feed(client, id)
    nf = Databasedotcom::Chatter::NewsFeed.find(client, id)
  end

  # Returns array where each elemet is a hash. The has has following keys.
  # :feeditem is a feeditem ruby object
  # :parent is the post which starts the feed
  # :comment is the array of comments for parent post.
  def all_feeds_of(client, id)
    news_feeds = self.get_news_feed(client, id)
    posts = []
    news_feeds.each do |n|
      n.comment("This is created by blanco")
      post = {:feeditem =>n, :parent => n.raw_hash, :comments => n.comments}
      posts << post
    end
    posts
  end

end

class String
  def to_ue
    CGI.unescapeHTML(self)
  end
end

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

#cp = Chatterprofile.new("yangkookkim@kvh.co.jp", "mika0507qWFzQkU3w9VYDa8fDC0JspdX")
#posts = cp.all_feeds_of("me")
#posts.each do |p|
#  txt = p[:parent]["body"]["text"]
#  puts txt.to_ue
#end
