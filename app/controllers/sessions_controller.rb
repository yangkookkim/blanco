require 'databasedotcom'
class SessionsController < ApplicationController
  def create
    ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
    ENV['sfdc_instance_url'] = request.env['omniauth.auth']['credentials'].instance_url
    client = Databasedotcom::Client.new(:client_id => "3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X", :client_secret => "2647515227667638785")
    client.authenticate :token => ENV['sfdc_token'], :instance_url => ENV['sfdc_instance_url']
    my_feed_items = Databasedotcom::Chatter::UserProfileFeed.find(client)
    #my_feed_items.each do |feed_item|
    #  feed_item.likes                   #=> a Databasedotcom::Collection of Like instances
    #  puts feed_item.comments                #=> a Databasedotcom::Collection of Comment instances
    #  feed_item.raw_hash                #=> the hash returned from the Chatter API describing this FeedItem
    #  feed_item.comment("Kim's test from blanco. Sorry for bothering!!") #=> create a new comment on the FeedItem
    #  feed_item.like                    #=> the authenticating user likes the FeedItem
    #end 
    render :text => request.env
  end
end
