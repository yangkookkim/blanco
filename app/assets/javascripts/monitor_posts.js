$(function(){
    monitor_posts_ws = new WebSocket("ws://localhost:51233");
 
    monitor_posts_ws.onmessage = function(evt) {
    	alert(evt.data)
    };

    monitor_posts_ws.onclose = function() {
        console.log("closing from monitor_posts.rb...-client side")
    };

    monitor_posts_ws.onopen = function() {
    	// To send data to monitor_posts.rb, data format should be json type string. (not json data)
    	// So, first convert cookie string to json data, and then convert it to json type string.
    	var unread_posts_json = jQuery.parseJSON($.cookie("unread_posts"));
    	var unread_posts_str = JSON.stringify(unread_posts_json);
        monitor_posts_ws.send(unread_posts_str);
    };		    	
});