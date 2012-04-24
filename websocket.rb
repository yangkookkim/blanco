require 'active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'em-websocket'
require "net/http"
require 'json'
require './app/uploaders/image_uploader'
Dir.glob('./app/uploaders/*').each { |r| require r }
Dir.glob('./app/models/*').each { |r| require r }


ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :host => 'localhost',
   :database => './db/development.sqlite3'
 )

# This is required to avoid the error of "url.rb:18:in `expand_path': can't convert nil into String (TypeError)"
CarrierWave.configure do |config|
  config.root = File.expand_path(File.dirname($0)) + "/public"
end

module BlancoWebSocket
  def join_channel(id, channels)
      channels[id] = [] unless channels.key?(id)
      channels[id] << self unless channels[id].include?(self)
      puts "DEBUG join_channel"
      puts channels[id]
  end
end

module JsonHelper
  def concat_json_object(*object)
    str = ""
    object.each {|j|
      str = str + j.to_json
    }
    return str.sub(/}{/, ',')
  end
end

channels = Hash.new
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 10000) do |ws|
  include JsonHelper
  ws.extend(BlancoWebSocket)
  
  ws.onopen {
  }
  
  ws.onmessage { |data|
    msg = JSON.parse(data) # msg is JSON
    operation = msg["operation"]
    channel_name = msg["channel"]    
    message = msg["message"]

  if operation == "publish"
	@post = Post.find(message["id"])
        channels[channel_name].each {|con|
          con.send(@post.to_json) #send message to clients
        }
  elsif operation == "subscribe"
        puts "operation: subscribe into #{channels[channel_name]}"
        ws.join_channel(channel_name, channels) # People who join the channel already setup
  elsif operation == "deletepost"
    puts "operation: DELETEPOST"
    @post = Post.find(post["id"])
    @post.destroy
    res_json = {"res" => {"success" => "1", "id" => post["id"]}}.to_json
        channels[channel["id"]].each {|con|
          con.send(res_json) #send message to clients
        }
  else
    puts "operation: #{msg["operation"]} is UNKNOWN"
  end
  }
  
  ws.onclose {
  }
end
