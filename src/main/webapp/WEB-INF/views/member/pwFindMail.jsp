<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<HTML LANG="ko">

<HEAD>

<META charset="UTF-8">
<META http-equiv="X-UA-Compatible" content="IE=edge">
<META name="viewport" content="width=device-width, initial-scale=1.0">
<TITLE>HobbyCloud - 비밀번호 찾기</TITLE>

<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet" href="https://bootswatch.com/5/journal/bootstrap.css">
<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- JQuery 3.6.0 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style type="text/css">

tbody.locTBody { cursor:pointer; }

</style>

<script type='text/javascript'>

// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function wrapclear(){
	
	$('.modal').css('opacity','0').css('display','none');
	
    // 모달 변수 정의
    window.modal = new bootstrap.Modal(document.getElementById("modal"), {
        keyboard: false
    });
});

// 라이브러리: 이벤트 버블링 막기
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}
    
$(function(){
	$("#findbtn").click(function(){
			alert("작동시작");
			
		    // 이벤트 버블링 막기
		    stopEvent();
		    
			var memberId = $("#memberId").val();
			var memberNick = $("#memberNick").val();
			var memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("memberNick : " + memberNick);
			 console.log("memberEmail : " + memberEmail);
			    $.ajax({
			    	type : "post",
			        url : "pwFindMail",
			        data : {"memberId" : memberId, "memberNick" : memberNick, "memberEmail" : memberEmail},
			        success : function(resp){
			        	console.log()
			        	alert("ajax 성공!! ");
			        	alert(resp);
			        	console.log("resp : " + resp);
			        	if(resp == "success") {
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("임시비밀번호가 전송되었습니다.");
	
			        	} else {
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("비밀번호 재설정이 실패했습니다.");
			        		}
			        	}
			    });
			    // 모달 토글
			    modal.toggle();
		});
	 });

</script>

</HEAD>

<BODY>

<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->
<div id="modal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <!-- 모달 제목 영역 -->
            <div class="modal-header">
                <!-- 모달 타이틀 -->
                <h5 class="modal-title">비밀번호 찾기</h5>
                <!-- 모달 닫기 버튼 -->
                <!-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. -->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button>               
            </div>
            <!-- 모달 본문 영역 -->
            <div class="modal-body table table-striped">
                <div>
                    <p class="modal-detail">
						회원님의 임시비밀번호를 이메일로 보내드렸습니다.
                   </p>
                   <div class="buttons">
                   <button onclick="location.href='pwFindMail'">다시찾기</button>
                   <button onclick="location.href='login'">로그인</button>                 
                   </div>
                </div>

            <!-- 모달 꼬리말 영역 -->
        </div>
    </div>
</div>
</div>

    <div class="wrap" >
           <div id="cont1">
               <div id = "panel" class="panel panel-default">
               <div class="panel-heading">
                   비밀번호 찾기
               </div>
               <div class="panel-body">
               <div class="subGroup">
				<button>Email</button>
				</div>
					<input type="text" id="memberId" name="memberId" placeholder="ID">
					<br> 
					<input type="text" id="memberNick" name="memberNick" placeholder="닉네임">
					<br>
					<div class="inputag">
					   <input type="text"  id="idMail" name="email_id" placeholder="EMAIL" >
						@
						<input type="text" id="inputMail" name="email_domain" placeholder="EMAIL" >
					</div>
                  <br>				 
				</div>
               </div>
           </div>
         </div>

<!-- 모달 여는 버튼 -->
<button type="button" id="findbtn" class="btn btn-primary m-3 p-3">임시비밀번호 발급하기</button>

</BODY>

</HTML>
