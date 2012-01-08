# -*- coding: utf-8 -*-
require 'em-websocket'
require "net/http"
require 'json'

def setup_channel(ws, id, channels)
    channels[id] = Array.new
end

def join_channel(ws, id, channels)
    channels[id] << ws
end

def create_post_via_http(host, port, data)
    Net::HTTP.version_1_2
    http = Net::HTTP.new(host, port)
    emp_id = data["post"]["employee_id"]
    grp_id = data["post"]["group_id"]
    pst_msg = data["post"]["message"]
    res = http.post("/employees/#{emp_id}/groups/#{grp_id}/posts",
                    "post[employee_id]=#{emp_id}&post[group_id]=#{grp_id}&post[message]=#{pst_msg}")
    return res
end

Process.daemon(nochdir=true) if ARGV[0] == "-D"
connections = Array.new
channels = Hash.new

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 51234) do |ws|
  ws.onopen {
  }
  
  ws.onmessage { |data| 
    msg = JSON.parse(data) # msg is JSON 
    channel_id = msg["channel"]["id"]
    # First person to join this channel
    setup_channel(ws, channel_id, channels) unless channels.key?(channel_id)
    # People who join the channel already setup
    join_channel(ws, channel_id, channels) unless channels[channel_id].include?(ws)
    create_post_via_http("127.0.0.1", 3000, msg)
    ws.send(msg["post"]["message"].force_encoding("UTF-8")) #to myself
    channels[channel_id].each {|con|
      con.send(msg["post"]["message"].force_encoding("UTF-8")) unless con == ws #to other people
    }
  }
  
  ws.onclose {
  }
end
