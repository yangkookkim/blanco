var runningRequest = false;
var request;

//Identify the typing action
$(function(){
    $('input#q').keyup(function(e){
        e.preventDefault();
        var $q = $(this);

        if($q.val() == ''){
            $('div#instant_search_results').html('');
            return false;
        }

        //Abort opened requests to speed it up
        if(runningRequest){
            request.abort();
        }

        runningRequest=true;
        request = $.getJSON('instant_search',{
        	//Not to search myself, m: passes the name of myself to query
            q:$q.val(), m:$("#display_name p").text()
        },function(data){           
            showResults(data,$q.val());
            runningRequest=false;
});

function showResults(data, highlight){
           var resultHtml = '';
            $.each(data, function(i,item){
                resultHtml+='<div class="instant_search_result">';
                resultHtml+='<p>'+ item.name +'</p>';
                resultHtml+='</div>';
            });

            $('div#instant_search_results').html(resultHtml);
        }
    });
})

$(function(){
        $(".instant_search_result").live("click", function(){
                var flag = false;
                var group_member = '';
                var group_member_input = '';
                var group_members = 'group_members[]';
                group_member+='<div class="group_member">'
                group_member+='<p>'+ $(this).text() +'</p>';
                group_member+='</div>'
                group_member_input+='<div class="group_member_input">'
                group_member_input+='<input name='+ group_members +' type="hidden" value='+ $(this).text()+ ' />'
                group_member_input+='</div>'
                var expr = $(this).text();
				// Check if any members already selected
				
                if($(".group_member p").length != 0){
				// Get each members already selected
                        $(".group_member p").each(function(index, domEle){
								// If the membere that you want add already exists, exit from the loop
                                if($(domEle).text() == expr){
                                        flag = false;
                                        return false;
                                }
                                flag = true;
                        });
						// Now you know that the member you want to add is not selected yet, so add it
                        if(flag == true){
                                $("#group_members").append(group_member);
                                $("#new_group").append(group_member_input);
                        }
				// If no members is selected yet, just add it
                }else{
                        $("#group_members").append(group_member);
                        $("#new_group").append(group_member_input);
                }
        });
});

$(function(){
	$(".group_member").live("click", function(){
		var name = $(this).text();
	 	$('.group_member_input input[value='+ name+ ']').remove();
		$(this).empty();
	});
});