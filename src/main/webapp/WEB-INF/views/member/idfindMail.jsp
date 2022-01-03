<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<HTML LANG="ko">

<HEAD>

<META charset="UTF-8">
<META http-equiv="X-UA-Compatible" content="IE=edge">
<META name="viewport" content="width=device-width, initial-scale=1.0">
<TITLE>HobbyCloud - 아이디 찾기</TITLE>

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
	
	// 이메일 유효성 검사
	
    $("#emailBox").change(function() {
        if ($("#emailBox").val() == "directly") {
            $("#inputMail").attr("readonly", false);
            $("#inputMail").val("");
            $("#inputMail").focus();
             $("#inputMail").keyup(function(){
                 if(!email_domail.test($("#inputMail").val())){
		                    $("#mailComm").text("");
		                    $("#mailComm").css("color", "red");
		                    $("#mailComm").html("이메일 형식이 맞지 않습니다.");
		                    
		                    mailBoxCheck = false;
		                    
                    } else {
                        $("#mailComm").html("");
                        
                        mailBoxCheck = true;
                    }
                 });
        }  else {
            $('#inputMail').val($('#emailBox').val());
            $("#inputMail").attr("readonly", true);
        }
    });
	
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
		    
		    //닉네임 이메일 (닉네임 이메일 전달)
			var memberNick = $("#memberNick").val();
			var memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("memberNick : " + memberNick);
			 console.log("memberEmail : " + memberEmail);
			    $.ajax({
			    	type : "post",
			        url : "idfindMail",
			        data : {"memberNick" : memberNick, "memberEmail" : memberEmail},
			        success : function(resp){
			        	console.log()
			        	alert("ajax 성공!!");
			        	alert(resp);
			        	console.log("resp : " + resp);
			        	if(resp == "fail") {
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("일치하는 회원정보가 없습니다.");	
			        	} else {
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("회원님의 아이디는 " + resp + " 입니다");
			        	}
			        }, 
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
                <h5 class="modal-title">아이디찾기</h5>
                <!-- 모달 닫기 버튼 -->
                <!-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. -->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button>
                
            </div>
            <!-- 모달 본문 영역 -->
            <div class="modal-body table table-striped">
                <div>
                    <p class="modal-detail">
						회원님의 아이디는 ${memberDto.memberId} 입니다.
                   </p>
                   <div class="buttons">
                   <button class="button reser payment" onclick="location.href='login'">로그인</button>
                   <button class="button reser clear" onclick="location.href='pwFindMail'">비밀번호 찾기</button>
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
                   아이디 찾기
               </div>
               <div class="panel-body">
               	<br><br>
               	<div class="tabGroup">
               	<button>Email</button>
				</div>
				<div id="cate1" class="tabcontent">
				<input type="text" id="memberNick" class="input form-control" name="memberNick" placeholder="닉네임">
				<br>
				<div class="inputag">
				   <input type="text"  id="idMail" name="email_id" class="input form-control"  placeholder="EMAIL" required>
					@
					<input type="text" id="inputMail" name="email_domain" class="input form-control" required readonly placeholder="EMAIL" >
					<select id="emailBox" name="emailBox" required>
						<option value="" class="pickMail">이메일 선택</option>
						<option value="directly">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="nate.com">nate.com</option>
					</select>				
				 </div>					 
				</div>
               </div>
           </div>
         </div>
      </div>

<!-- 모달 여는 버튼 -->
<button type="button" id="findbtn" class="btn btn-primary m-3 p-3" data-bs-toggle="modal" data-bs-target="#modal">찾기</button>

</BODY>

</HTML>
