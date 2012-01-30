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
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 51234) do |ws|
  include JsonHelper
  ws.extend(BlancoWebSocket)
  
  ws.onopen {
  }
  
  ws.onmessage { |data|
    msg = JSON.parse(data) # msg is JSON
    post = msg["post"]
    operation = msg["operation"]
    channel = msg["channel"]    

  if operation == "setupcon"
        puts "operation: START CON"
        ws.join_channel(channel["id"], channels) # People who join the channel already setup
  elsif operation == "sendmsg"
      if post["id"] == nil
        @post = Post.create(post) # post is a hash which contains attributes of post
        @employee = @post.employee
      else
        @post = Post.find(post["id"])
        @post.update_attribute(:message, post["message"])
        @employee = @post.employee
      end       
        json_objects = concat_json_object(@post, @employee) # jsonize objects and put them together
        channels[channel["id"]].each {|con|
          con.send(json_objects) #send message to clients
        }
  else
    puts "operation: UNKNOWN"
  end
  }
  
  ws.onclose {
  }
end
