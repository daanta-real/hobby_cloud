<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML LANG="ko">
<HEAD>
<META charset="UTF-8">
<META http-equiv="X-UA-Compatible" content="IE=edge">
<META name="viewport" content="width=device-width, initial-scale=1.0">
<title>HobbyCloud - Email 변경하기</title>

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

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
    
    // 모달 변수 정의
    window.modal = new bootstrap.Modal(document.getElementById("modal"), {
        keyboard: false
    });
});

//라이브러리: 이벤트 버블링 막기
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

	$(function(){
		let email = '${memberDto.memberEmail}';

		$('input[name="email_id"]').val(email.substr(0,email.indexOf("@")));
		$('input[name="email_domain"]').val(email.substr(email.indexOf("@")+1,email.length));
		
	})

	$(function(){
		
		 // 이벤트 버블링 막기
		stopEvent();
		
		/* 정규표현식 변수 */
		var email_id = RegExp(/^[a-zA-Z0-9_-]{4,20}$/); 
		var email_domail = RegExp(/^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/); 
		
		//이메일아이디 유효성검사
		 $("#idMail").keyup(function(){
		      if(!email_id.test($("#idMail").val())){
			         $("#mailComm").text("");
			         $("#mailComm").css("color", "red");
			         $("#mailComm").html("이메일 형식이 맞지 않습니다.");
			         
			         $("#findbtn").prop("disabled", true);
			         $("#findbtn").css("color", "gray");
		         } else {
		        	 $("#mailComm").html("");
		        	 $("#findbtn").prop("disabled", false);
		         }
		  });
		 
		 //이메일 유효성 검사
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
		                    
		                    $("#findbtn").prop("disabled", true);
		                    $("#findbtn").css("color", "gray");
                        } else {
                            $("#mailComm").html("");
                            $("#findbtn").prop("disabled", false);
                        }
                     });
            }  else {
                $('#inputMail').val($('#emailBox').val());
                $("#inputMail").attr("readonly", true);
            }
        });		
		
		 //이메일 인증
	    $("#emailCheck").click(function(){
	        console.log("이메일 인증 id : " + $("#idMail").val());
	        console.log("이메일 인증 domain : " + $("#inputMail").val());
	        console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
	        sendMail();
	    }); 
	    
		//이메일 인증번호
        $("#reKey").keyup(function(){
        	$("#findbtn").css("color", "gray");
        	$("#findbtn").prop("disabled", true);
        });
		
		//이메일 주소 합
     	$("#findbtn").click(function(){
    		let email = $("#idMail").val() + "@" + $("#inputMail").val();    		

    		$('input[name="email"]').val(email);
    	})
		
    	//이메일 수정
    	$("#findbtn").click(function(){
    		//합해진 이메일 주소
    		console.log("이메일 수정 ajax 실행");
			let memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();

			 $.ajax({
			    	type : "post",
			        url : "edit",
			        data : {"memberEmail" : memberEmail},
			        success : function(resp){
			        	if(resp == "redirect:edit_success") {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("Email이 정상적으로 수정되었습니다.");

			        	} else {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("Email 변경에 실패했습니다. <br> 다시 시도해주세요");
			        	}
			        }, 
			    });		
	 });		
});

		//이메일 인증 
		function sendMail() {
			var mailAddr = $("#idMail").val() +"@"+ $("#inputMail").val();
		
			$.ajax({
		    	type : "post",
		        url : "sendMail",
		        data : {"email" : mailAddr},
		        success : function(resp){
		        	alert("메일이 성공적으로 보내졌습니다."+resp);
		        	$("#reKeyCheck").click(function(){
		        		if(resp == $("#reKey").val()) {
		        			alert("인증이 완료");
						
		            		$("#findbtn").prop("disabled", false);
		    		        $("#findbtn").css("color", "white");
		            	} else {
		            		alert("인증번호가 다릅니다. 다시 인증해주세요");
		            		$("#reKey").focus();
		            		$("#findbtn").prop("disabled", true);
		    		        $("#findbtn").css("color", "gray");
		            	}
		        	});
		        },
				error : function(jqXHR, textStatus, errorThrown){
					alert("Ajax 처리 실패 : \n"
							+"jqXHR.readyState : " + jqXHR.readyState + "\n"
							+"textStatus : " + textStatus + "\n"
							+"errorThrown : " + errorThrown);
					
				}
			})
		}
		  
</script>
</HEAD>

<body>
<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->
<div id="modal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <!-- 모달 제목 영역 -->
            <div class="modal-header">
                <!-- 모달 타이틀 -->
                <h5 class="modal-title">이메일 수정</h5>
                <!-- 모달 닫기 버튼 -->               
                <!-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. -->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button>               
            </div>
            <!-- 모달 본문 영역 -->
            <div class="modal-body table table-striped">
            	<div>
            		  <p class="modal-detail">            		  	
            		  </p>
            		 <div class="buttons">
                        <button class="button reser payment" onclick="location.href='main'">확인</button>
                      </div>
                      
                      <button type="button" class="popup-close">
                      </button>
                  </div>
               </div>
            </div>
         </div>
      </div>
		<body>
	    <div class="wrap" >
            <div id="cont1">
                <div id = "panel" class="panel panel-default">
                <div class="panel-heading">
                     Email 변경하기
                </div>
                 <div class="panel-body">
					<br>
					<input type="text" id="idMail" name="email_id" class="input form-control" required> @
                    <input type="text" id="inputMail" name="email_domain" class="input form-control" required readonly>
                        <select id="emailBox" name="emailBox" class="input form-control" required>
                            <option value="" class="pickMail">이메일 선택</option>
                            <option value="directly">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="nate.com">nate.com</option>
                        </select>
                        <input type="button" id="emailCheck" class="adCheck" value="인증하기">
                        <input type="hidden" name="email" >
                        <div id="mailComm"></div>

					<input type="text" id="reKey" class="input form-control" maxlength="20" placeholder="인증번호를 입력해주세요" required>
                   	<input type="button" id="reKeyCheck" class="adCheck" value="확인">
                  <br>
                  <br>
                </div>
            </div>
                <div class="button-box">
				<input type="button" class="btn btn-default btn01" value="뒤로가기" onclick="history.back()">   
				 
				 <!-- 모달 여는 버튼 -->
				<button type="button" id="findbtn" class="btn btn-primary m-3 p-3">변경하기</button>
			</div>     


        </div>

    </div>
	
</body>
</html>