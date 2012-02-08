var runningRequest = false;
var request;

//Identify the typing action
$(function(){
    $('input.global_instant_search_box').keyup(function(e){
        e.preventDefault();
        var $q = $(this);
        var type = $(this).attr("name");

        if($q.val() == ''){
            $('.global_instant_search_result').html('');
            return false;
        }

        //Abort opened requests to speed it up
        if(runningRequest){
            request.abort();
        }

        runningRequest=true;
        request = $.getJSON('/instant_search',{
        	//Not to search myself, m: passes the name of myself to query
            q:$q.val(), query_type:type
        },function(data){
            showResults(data,$q.val());
            runningRequest=false;
});

function showResults(data, highlight){
       var resultHtml = '';

       $.each(data, function(i,item){
	   var iconurl = '';
	   var iconhtml = '';
		if (item.icon.thumb.url != null) {
			iconurl = item.icon.thumb.url
			iconhtml = '<img alt="employee image" src='+ iconurl +' align="middle" />';
		}
                resultHtml+='<div class="global_instant_search_result">';
                resultHtml+='<div>' + '<div class="eachresult">' + '<span class="resulticon">'+ iconhtml +'</span>'+ '<span class="resultname">' + '<a href="/employees/' + item.id + '/profiles/' + item.id + '" >' + item.name +'</a>' + '</span>' + '</div>' + '</div>';
                resultHtml+='</div>';
            });
            $('ul#global_instant_search_result').html("<li>"+ resultHtml +"</li>");
        }
    });
})

$('html').click(function(event) {
	if(!$(event.target).is("ul#global_instant_search_result *")) {
		$('.global_instant_search_result').html('');
		$('input.global_instant_search_box').val('');
	};
});

