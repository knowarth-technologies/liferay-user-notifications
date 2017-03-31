	AUI().ready('aui-module', function(A){
		debugger
		A.one("#redirectDiv").on('click',function(){
			A.one('#notification-data').toggleView();
		});
	});
	var A=AUI();
	var portletNameSpace=A.one('#portletNameSpace').val();
	var userEventId=portletNameSpace+'userNotificationEventId';
	function markAsRead(eventId){
		console.log(eventId);
		var portletResourceURL=$('#portletResourceURL').val()+'&'+userEventId+'='+eventId;
		A.io.request(portletResourceURL,{
			dataType: 'json',
			data:{callFor : 'markAsRead',
				userEventId:eventId
			},
			method:'post',
			on:{
				success:function(event){
					var row_Id= ".notification_" + eventId;
					A.one(row_Id).ancestor("li").remove();
					var eventCounts=A.one("span.eventCounts").text().trim()-1;
					A.one("span.eventCounts").text(eventCounts);
				},
						failure:function(event){
							alert("Something Went Wrong, Please Try Again");
						}
				}
			});

	
	}