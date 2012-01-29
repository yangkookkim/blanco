require 'active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'em-websocket'
require "net/http"
require 'json'
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

def concat_json_object(*object)
  str = ""
  object.each {|j|
    str = str + j.to_json
  }
  return str.sub(/}{/, ',')
end

def setup_channel(ws, id, channels)
    channels[id] = Array.new
end

def join_channel(ws, id, channels)
    channels[id] << ws
end

connections = Array.new
channels = Hash.new

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 51234) do |ws|
  ws.onopen {
  }
  
  ws.onmessage { |data| 
    msg = JSON.parse(data) # msg is JSON 
    channel_id = msg["channel"]["id"]
    if msg["post"]["img_id"] == 999
      puts "START CON"
      # First person to join this channel
      setup_channel(ws, channel_id, channels) unless channels.key?(channel_id)
      # People who join the channel already setup
      join_channel(ws, channel_id, channels) unless channels[channel_id].include?(ws)
    elsif msg["post"]["img_id"] == 0
      puts "NEW POST"
      message = msg["post"]["message"]
      employee_id  = msg["post"]["employee_id"]
      group_id = msg["post"]["group_id"]
      @post = Post.new(:message => message, :employee_id => employee_id, :group_id => group_id)
      @post.save
      @employee = @post.employee
      s = concat_json_object(@post, @employee)
      ws.send(s)
      channels[channel_id].each {|con|
        con.send(msg["post"]["message"].force_encoding("UTF-8")) unless con == ws #to other people
      }
    else
      puts "UPDATE POST"
      id = msg["post"]["img_id"].to_i
      message = msg["post"]["message"]
      employee_id  = msg["post"]["employee_id"]
      group_id = msg["post"]["group_id"]
      puts "DEBUG1"
      @post = Post.find(id)
      @post.to_json
      puts "DEBUG2"
      @post.update_attribute(:message, message)
      @employee = @post.employee
      s = concat_json_object(@post, @employee)
      puts "DEBUG3"
      ws.send(s)
      channels[channel_id].each {|con|
        con.send(msg["post"]["message"].force_encoding("UTF-8")) unless con == ws #to other people
      }
    end
  }
  
  ws.onclose {
  }
end
