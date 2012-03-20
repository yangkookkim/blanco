require 'pp'
require 'databasedotcom'
client = Databasedotcom::Client.new(:client_id => "3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X", :client_secret => "2647515227667638785")
client.authenticate :username => "yangkookkim@kvh.co.jp", :password => "mika0507qWFzQkU3w9VYDa8fDC0JspdX"
userid = "005d0000000jI0P"
gf = Databasedotcom::Chatter::RecordFeed.post(client, "0F9d0000000H1yvCAC", :text => "aaa")

#feeditem.post(client, "me", :text => "This is a status update about Salesforce.")
#my_feed_items.each do |feed_item|
#  feed_item.delete
#end
