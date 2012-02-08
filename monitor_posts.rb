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

channels = Hash.new
all_group = Group.all
monitor_requests = Hash.new
all_group.each {|g|
  monitor_requests[g.id] = Array.new 
}

module JsonHelper
  def concat_json_object(*object)
    str = ""
    object.each {|j|
      str = str + j.to_json
    }
    return str.sub(/}{/, ',')
  end
end

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 20000) do |ws|
  include JsonHelper
  ws.onopen { |data|
    puts "client connected..."
  }
  
  # Data that client sends on onopen is recived here.
  ws.onmessage { |data|
    msg = JSON.parse(data)
    
    if msg["operation"] == "update"
      sleep(0.5) # Wait for the access to database by creating post finishes
      channel = msg["channel"]
      grp_id = channel["id"]
      updated_group = Group.find(grp_id)
      updated_post = updated_group.posts.last
      puts "#{updated_group.name} is updated!!"
      
      json_data = concat_json_object(updated_group, updated_post)
      monitor_requests[grp_id].each {|con|
          con.send(json_data)
      }
    else
      msg.each_key {|k|
        grp_id = Group.find_by_name(k).id
        monitor_requests[grp_id] << ws
      }
    end
  }
  
  ws.onclose {
  }
end
