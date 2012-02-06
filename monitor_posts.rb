require 'active_record'
require 'em-websocket'
require "net/http"
require 'json'
require './app/models/group'

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

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 51233) do |ws|
  ws.onopen { |data|
    puts "client connected..."
  }
  
  # Data that client sends on onopen is recived here.
  ws.onmessage { |data|
    msg = JSON.parse(data)
    
    if msg["operation"] == "update"
      sleep(2) # Wait for the access to database by creating post finishes
      channel = msg["channel"]
      id = channel["id"]
      updated_group = Group.find(id)
      puts "#{updated_group.name} is updated!!"
      
      monitor_requests[id].each {|con|
          con.send("updated") #send message to clients
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
