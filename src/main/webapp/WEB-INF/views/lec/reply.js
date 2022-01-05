function replyList(){
		//#result에 목록을 불러와서 출력
		var lecIdxValue = $("lecIdxValue").data("lec-idx");
		$.ajax({
			url:"${pageContext.request.contextPath}/data/data4",
			type:"get",
			data:{
				lecIdx:lecIdxValue
			},
			dataType:"json",
			success:function(resp){
				console.log("성공",resp);
				$("#result").empty();//내부영역 청소
				//$("#result").html("");
				//$("#result").text("");
				
				for(var i=0; i < resp.length; i++){
					var template = $("#lecDetailVO-template").html();
					
					template = template.replace("{{lecReplyIdx}}",resp[i].lecReplyIdx);
					template = template.replace("{{memberNick}}",resp[i].memberNick);
					template = template.replace("{{lecReplyDetail}}",resp[i].lecReplyDetail);
					template = template.replace("{{lecReplyRegistered}}",resp[i].lecReplyRegistered);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
						deleteData($(this).data("lecReplyIdx"));
					});
					tag.find(".edit-btn").click(function(){
						var lecReplyDetail = $(this).prevAll(".lecReplyDetail").text();
						
						var form = $("<form>");
						form.append("<input type='hidden' name='lecReplyIdx' value='"+lecReplyIdx+"'>");
						form.append("<input type='text' name='lecReplyDetail' value='"+lecReplyDetail+"'>");
						form.append("<button type='submit'>수정</button>");
						
						form.submit(function(e){
							e.preventDefault();
							
							//ajax...
						});
						
						var div = $(this).parent();
						div.html(form);
					});
					$("#result").append(tag);//추가!
				}
			},
			error:function(e){}
		});
	}