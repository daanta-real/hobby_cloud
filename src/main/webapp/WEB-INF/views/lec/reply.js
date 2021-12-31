function ReplyList(lecIdx){
	$.ajax({
		url : "${pageContext.request.contextPath}/lec/replyList",
		type : "get",
		data : {
			lecIdx : lecIdx
		},
		success : function(resp){
			console.log("댓글 리스트 불러오기 성공");
			
			// 댓글 목록 html로 담기
			var listHtml = "";
			for(var i in resp){
				var lecReplyIdx = resp[i].lecReplyIdx;
				var memberIdx = resp[i].memberIdx;
				var lecIdx = resp[i].lecIdx;
				var memberNick = resp[i].memberNick;
				var lecReplyDetail = resp[i].lecReplyDetail;
				var lecReplyRegistered = resp[i].lecReplyRegistered;
				var lecReplySuperidx = resp[i].lecReplySuperidx;
				var lecReplyGroupno = resp[i].lecReplyGroupno;
				var lecReplyDepth = resp[i].lecReplyDepth;
				
				console.log(lecReplyDepth); // 모댓글은 0, 대댓글이면 1
				
				listHtml += "<div class='row replyrow reply" + lecReplyIdx + "'>";
				
				if(lecReplyDetail == ""){// 삭제된 댓글일때
					listHtml += "<div>";
					listHtml += "(삭제된 댓글입니다)";
					listHtml += "</div>";
				}else{
					if(lecReplyDepth == 0){// 모댓글일때
						listHtml += "<div class='col-1'>";
						listHtml += "		<a href='member/profile?memberIdx="+memberIdx+">";
						listHtml += "			<img src='${pageContext.request.contextPath}/member/file/"+memberIdx+"'>";
						listHtml += "		</a>";
						listHtml += "</div>";
						listHtml += "<div class='rereply-content'>";
						listHtml += "		<div>";
						listHtml += "			<span>";
						listHtml += "				<strong>"+memberNick+"</strong>";
						listHtml += "			</span>";
						listHtml += "			<span>";
						listHtml += 				lecReplyDetail;
						listHtml += "			</span>";
						listHtml += "		</div>";
						// 현재 로그인 상태일때 답글작성 버튼 나옴
						if("${memberNick}" != ""){
							listHtml += "<div>";
							// 함수에 강좌번호(lecIdx), 모댓글번호(lecReplyIdx), 모댓글
							// 작성자(memberIdx)를 인자로 담아서 넘기기
							listHtml += "		<a href='#' class='write_reply_start' data-bs-toggle='collapse' data-bs-target='#re_reply"+lecReplyIdx+"' aria-expanded='false' aria-controls='collapseExample'>답글&nbsp;달기</a>";
							listHtml += "</div>";
						}
						listHtml += "</div>";
						
					}else{// 답글일때
						listHtml += "<div class='col-1'>";
						listHtml += "</div>"
						listHtml += "<div class='col-1'>";
						listHtml += "			<img src='${pageContext.request.contextPath}/member/file/"+memberIdx+"'>";
						listHtml += "</div>";
						listHtml += "div class='reply-content"+lecReplyIdx+" col-7'>";
						listHtml += "		<div>";
						listHtml += "			<span>";
						listHtml += "				<strong>"+memberNick+"</strong>";
						listHtml += "			</span>";
						listHtml += "			<span>";
						listHtml += 				lecReplyDetail;
						listHtml += "			</span>";
						listHtml += "		</div>";
						
						listHtml += "</div>";
					}
					
					listHtml += "<div class='col-3 reply-right'>";
					listHtml += "		<div>";
					listHtml += 		lecReplyRegistered;
					listHtml += "		</div>";
					//현재 로그인 상태이면
					if("${memberNick}" != ""){
						//현재 사용자가 이 댓글의 작성자일때 수정과 삭제 버튼 나옴
						if("${memberNick}" == memberNick){//세션의 memberNick과 작성자 memberNick 비교
							listHtml += "<div>";
							//수정할 댓글의 lecReplyIdx와 lecReplyDepth를 넘긴다.
							//모댓글 수정칸과 답글 수정칸 화면 다르게 하려면 모댓글과 답글을 구분하는 lecReplyDepth를 함께 넘기면됌
							listHtml += "		<a href='javascript:' lecReplyIdx='"+lecReplyIdx+"' lecReplyDepth='"+lecReplyDepth+"' class='reply_modify'>수정</a>";
							listHtml += "		&nbsp; | &nbsp;";
							//삭제
							listHtml += "			<a href='javascript:' lecReplyIdx='"+ lecReplyIdx +"' lecReplyDepth='"+ lecReplyDepth + "' lecIdx='"+ lecIdx +"' lecReplyGroupno='"+ lecReplyGroupno +"' class='reply_delete'>삭제</a>";
							listHtml += "</div>";
						}
					}
					
					listHtml += "</div>";
					//댓글에 답글달기를 누르면 답글 입력란이 나옴
					//답글 입력란
					 listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ lecReplyIdx +"'>";
	                    listHtml += "		<div class='col-1'>"
	                    listHtml += "		</div>"
	                    listHtml += "		<div class='col-1'>"
                    	listHtml += "		<a href='member/profile?memberIdx="+memberIdx+">";
						listHtml += "			<img src='${pageContext.request.contextPath}/member/file/"+memberIdx+"'>";
						listHtml += "		</a>";
	                    listHtml += "		</div>"
	                    listHtml += "		<div class='col-7'>"
	                    listHtml +=  "  		<input class='w-100 input_rereply_div form-control' id='input_rereply"+ lecReplyIdx +"' type='text' placeholder='댓글입력...'>"
	                    listHtml += "		</div>"
	                    listHtml += "		<div class='col-3'>"
	                    // 답글달기 버튼이 눌리면 모댓글 번호(lecReplyIdx)와 게시물번호(lecIdx)를 함수에 전달한다.

	                    // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
	                    // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
	                    // 아래코드를 보자~~~~
	                    // listHtml += "			<button onclick='javascript:WriteReReply("+ lecReplyIdx +","+ lecIdx +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
	                    // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
	                    // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(lecReplyIdx, lecIdx)만 속성으로 넘겨주도록 작성한다.
	                    listHtml += "			<button type='button' class='btn btn-success mb-1 write_rereply' lecReplyIdx='" + lecReplyIdx + "' lecIdx='" + lecIdx + "'>답글&nbsp;달기</button>"
	                    listHtml += "		</div>";
	                    listHtml += "	</div>";
	                    // ---- 답글입력란 끝
	                }

	                listHtml += "</div>";


	            };

	            ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
	            ///////////// $(document).ready(function(){}); 안에 써주면 안된다.

	            // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
	            $(".reply-list"+lecReplyIdx).html(listHtml);

	            // 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
	            //$('.write_re_reply_start').on('click', function(){
	            //	$('#input_rereply'+ $(this).attr('lecReplyIdx')).val("@"+$(this).attr('writer')+" ");
	            //});

	            //답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
	            $('button.btn.btn-success.mb-1.write_rereply').click(function() {
	                console.log( 'lecReplyIdx', $(this).attr('lecReplyIdx') );
	                console.log( 'lecIdx', $(this).attr('lecIdx') );

	                // 답글을 DB에 저장하는 함수를 호출한다. lecIdx와 lecReplyIdx를 같이 넘겨주어야한다.
	                WriteReReply($(this).attr('lecIdx'), $(this).attr('lecReplyIdx') );
	            });

	            // 삭제버튼을 클릭했을 때
	            $('.reply_delete').click(function(){
	                // 모댓글 삭제일때
	                if($(this).attr('lecReplyDepth') == 0){	
	                    DeleteReply($(this).attr('lecReplyIdx'), $(this).attr('lecIdx'));

	                // 답글 삭제일때
	                }else{
	                    DeleteReReply($(this).attr('lecReplyIdx'), $(this).attr('lecIdx'), $(this).attr('lecReplyGroupno'));
	                }

	            })


	        },
	        error : function() {
	            alert('서버 에러');
	        }
	    });
	};
	
// 답글 달기 버튼 클릭시  실행 - 답글 저장, 댓글 갯수 가져오기
function WriteReReply(lecIdx,lecReplyIdx) {

    console.log(lecIdx);
    console.log(lecReplyIdx);

    console.log($("#input_rereply" + lecReplyIdx).val());

    // 댓글 입력란의 내용을 가져온다. 
    // ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
    var lecReplyDetail = $("#input_rereply" + lecReplyIdx).val();
    lecReplyDetail = lecReplyDetail.trim();


    if(lecReplyDetail == ""){	// 입력된게 없을때
        alert("글을 입력하세요!");
    }else{	
        // 입력란 비우기
        $("#input_rereply" + lecReplyIdx).val("");

        // reply+1 하고 그 값을 가져옴
        $.ajax({
            url : 'picture_write_rereply.do',
            type : 'get',
            data : {
                lecReplyIdx : lecReplyIdx,
                lecIdx : lecIdx,
                lecReplyDetail: lecReplyDetail
            },
            success : function(lecDto) {

                var reply = lecDto.lecReplies;
                // 페이지에 댓글수 갱신
                $('#m_reply'+lecIdx).text(reply);//
                $('#reply'+lecIdx).text(reply);

                console.log("답글 작성 성공");

                // 게시물 번호(lecIdx)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(lecIdx);
            },
            error : function() {
                alert('서버 에러');
            }
        });

    };
};

// 모댓글 삭제일때
function DeleteReply(lecReplyIdx, lecIdx){
    // lecReplyDepth이 lecReplyIdx인 댓글이 있는 경우 lecReplyDetail에 null을 넣고 없으면 삭제한다.
    $.ajax({
        url : 'picture_delete_reply.do',
        type : 'get',
        data : {
            lecReplyIdx : lecReplyIdx,
            lecIdx : lecIdx
        },
        success : function(lecDto) {

            var reply = lecDto.lecReplies;

            // 페이지에 댓글수 갱신
            $('#m_reply'+lecIdx).text(reply);
            $('#reply'+lecIdx).text(reply);

            console.log("모댓글 삭제 성공");

            // 게시물 번호(lecIdx)에 해당하는 댓글리스트를 새로 받아오기
            ReplyList(lecIdx);
        },
        error : function() {
            alert('서버 에러');
        }
    });
};

// 답글 삭제일때
function DeleteReReply(lecReplyIdx, lecIdx, lecReplyDepth){

    //console.log("lecReplyDepth : " + lecReplyDepth);

    // 답글을 삭제한다.
    $.ajax({
        url : 'picture_delete_rereply.do',
        type : 'get',
        data : {
            lecReplyIdx : lecReplyIdx,
            lecIdx : lecIdx,
            lecReplyDepth : lecReplyDepth
        },
        success : function(lecDto) {

            var reply = lecDto.lecReplies;

            // 페이지에 댓글수 갱신
            $('#m_reply'+lecIdx).text(reply);
            $('#reply'+lecIdx).text(reply);

            console.log("답글 삭제 성공");

            // 게시물 번호(lecIdx)에 해당하는 댓글리스트를 새로 받아오기
            ReplyList(lecIdx);
        },
        error : function() {
            alert('서버 에러');
        }
    });

};