<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {

	$(function(){
		
		let email = $(".idMail").val() + "@" + $(".inputMail").val();
		$('input[name="memberEmail"]').val(email);
		console.log(
			"이메일 합 : " + $(".idMail").val() + "@" + $(".inputMail").val()
			);
		
	})		
		/* 정규표현식 변수 */
		var email_id = RegExp(/^[a-zA-Z0-9_-]{4,20}$/); 
		var email_domail = RegExp(/^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/); 
		
		//이메일아이디 유효성검사
		 $(".idMail").keyup(function(){
		      if(!email_id.test($(".idMail").val())){
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
        $(".emailBox").change(function() {
            if ($(".emailBox").val() == "directly") {
                $(".inputMail").attr("readonly", false);
                $(".inputMail").val("");
                $(".inputMail").focus();
                 $(".inputMail").keyup(function(){
                     if(!email_domail.test($(".inputMail").val())){
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
                $('.inputMail').val($('.emailBox').val());
                $(".inputMail").attr("readonly", true);
            }
        });		
		
		 //이메일 인증
	    $(".emailCheck").click(function(){
	        console.log("이메일 인증 id : " + $(".idMail").val());
	        console.log("이메일 인증 domain : " + $(".inputMail").val());
	        console.log("이메일 합 : " + $(".idMail").val() + "@" + $(".inputMail").val());
	        sendMail();
	    }); 
	    
		//이메일 인증번호
        $("#reKey").keyup(function(){
        	$("#findbtn").css("color", "gray");
        	$("#findbtn").prop("disabled", true);
        });
		
		//이메일 주소 합
     	$("#findbtn").click(function(){
    		let email = $(".idMail").val() + "@" + $(".inputMail").val();    		

    		$('input[name="email"]').val(email);
    	})
    	
 	//이메일 변경
	$("#findbtn").click(function(){
		console.log("이메일 수정 ajax 실행");
		
		//합해진 이메일 주소
		let memberEmail = $(".idMail").val() + "@" + $(".inputMail").val();

		 $.ajax({
		    	type : "post",
		        url : "updateMail",
		        data : {"memberEmail" : memberEmail},
		        success : function(resp){
		        	if(resp == "success") {
		        		alert("이메일 수정이 성공적으로 진행되었습니다.");
		        		$('.modal').css('opacity','1').css('display','block');
		        		$(".modal-detail").text("");
				        $(".modal-detail").html("Email이 정상적으로 수정되었습니다.");

		        	} else {
		        		$('.modal').css('opacity','1').css('display','block');
		        		$(".modal-detail").text("");
				        $(".modal-detail").html("Email 변경에 실패했습니다. <br> 다시 시도해주세요");
		        	}
		        }, 
		    });
		});	
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
	
//이메일 인증

	function sendMail() {	
		alert("작동시작");
			
		var mailAddr = $(".idMail").val() +"@"+ $(".inputMail").val();
		
			$.ajax({
		    	type : "post",
		        url : "sendMail",
		        data : {"email" : mailAddr},
		        success : function(resp){
		        	alert("메일이 성공적으로 보내졌습니다."+resp);
		        	$("#reKeyCheck").click(function(){
		        		if(resp == $("#reKey").val()) {
		        			alert("인증 완료");
						
		            		$("#findbtn").prop("disabled", false);
		    		        $("#findbtn").css("color", "black");
		            	} else {
		            		alert("인증번호가 다릅니다. 다시 인증해주세요");
		            		$("#reKey").focus();
		            		$("#findbtn").prop("disabled", true);
		    		        $("#findbtn").css("color", "gray");
		            	}
		        	});
		        },
				error : function(jqXHR, textStatus, errorThrown){
					alert("메일보내기 실패 다시 시도해주세요");
					
				}
			})
		}
		  
</script>
</HEAD>
<BODY>
<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->

<jsp:include page="/resources/template/body.jsp" flush="false" />



<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->

<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
		     이메일 변경
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->

		<!-- 소단원 내용 -->
		<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->
		<div id="modal" class="modal" tabindex="-1">
	<div class="modal-dialog">
		 <div class="modal-content p-3">
            <!-- 모달 제목 영역 -->
            <div class="modal-header">
                <!-- 모달 타이틀 -->
                <h5 class="modal-title">이메일 변경</h5>
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
						<button class="button reser clear" onclick="location.href='login'">로그인</button>
						<button class="button reser payment" onclick="location.href='edit'">확인</button>
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
                     
                </div>
                <br><br><br>
                <div class="row p-sm-2 mx-1 mb-5">
                 <div class="panel-body container">
			    	<div class="row mb-4">
			    	<div class="input-group flex-nowrap grayInputGroup p-0">
						<input type="text" class="idMail form-control border-radius-all-25" name="email_id"  required>&nbsp;@&nbsp;
						<input type="text" class="inputMail form-control border-radius-all-25" name="email_domain" required readonly>&nbsp;
						<select class="emailBox form-control border-radius-all-25" name="emailBox" required>
							<option>이메일 선택</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="directly">직접입력</option>
						</select>
					<div>
						&nbsp;<button type="button" class="btn btn-outline-primary mt-1 btn-sm emailCheck"  value="인증하기" >인증하기</button>
						<input type="hidden" name="memberEmail" class="mail_input" >
					</div>
				</div>
				</div>
					<div id="mailComm"></div>
					<div class="row mb-4">
						<div class="input-group flex-nowrap grayInputGroup p-0">
						<input type="text" id="reKey" class="form-control border-radius-all-25" 
								maxlength="20" placeholder="인증번호를 입력해주세요" required>
						&nbsp;<button type="button" id="reKeyCheck" class="btn btn-outline-primary mt-1 btn-sm border-radius-all-25" value="확인" >확인</button>
						</div>
					</div>
              </div>
            </div> 
        </div>
       </div>
       </div>
       
 <!-- 모달 여는 버튼 -->
		<div class="button-box">
		<nav class="row d-flex form-group col-12">
            <div class="text-center">
            <button type="button" id="findbtn" class="btn btn-danger m-3 p-3" data-bs-toggle="modal" data-bs-target="#modal">이메일 변경</button>
            </div>
        </nav>
		<nav class="row p-0 pt-4 d-flex justify-content-end">
            <button class="button reser clear col-auto btn btn-sm btn-primary" onclick="location.href='login'">로그인</button>
            <button class="button reser clear col-auto btn btn-sm btn-secondary mx-2" onclick="location.href='edit'">뒤로가기</button>
         </nav>
		</div>   

</div>
		
		<!-- 소단원 제목 -->

		<!-- 소단원 내용 -->

	</SECTION>
	<!-- 페이지 내용 끝. -->

</ARTICLE>
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>
<%--디자인 적용전
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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

<style type="text/css">

tbody.locTBody { cursor:pointer; }

</style>

<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {

	$(function(){
		let email = '${memberDto.memberEmail}';

		$('input[name="email_id"]').val(email.substr(0,email.indexOf("@")));
		$('input[name="email_domain"]').val(email.substr(email.indexOf("@")+1,email.length));
		
	})		
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
    	
 	//이메일 변경
	$("#findbtn").click(function(){
		console.log("이메일 수정 ajax 실행");
		
		//합해진 이메일 주소
		let memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();

		 $.ajax({
		    	type : "post",
		        url : "updateMail",
		        data : {"memberEmail" : memberEmail},
		        success : function(resp){
		        	if(resp == "success") {
		        		alert("이메일 수정이 성공적으로 진행되었습니다.");
		        		$('.modal').css('opacity','1').css('display','block');
		        		$(".modal-detail").text("");
				        $(".modal-detail").html("Email이 정상적으로 수정되었습니다.");

		        	} else {
		        		$('.modal').css('opacity','1').css('display','block');
		        		$(".modal-detail").text("");
				        $(".modal-detail").html("Email 변경에 실패했습니다. <br> 다시 시도해주세요");
		        	}
		        }, 
		    });
		});	
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
	
//이메일 인증

	function sendMail() {	
		alert("작동시작");
			
		var mailAddr = $("#idMail").val() +"@"+ $("#inputMail").val();
		
			$.ajax({
		    	type : "post",
		        url : "sendMail",
		        data : {"email" : mailAddr},
		        success : function(resp){
		        	alert("메일이 성공적으로 보내졌습니다."+resp);
		        	$("#reKeyCheck").click(function(){
		        		if(resp == $("#reKey").val()) {
		        			alert("인증 완료");
						
		            		$("#findbtn").prop("disabled", false);
		    		        $("#findbtn").css("color", "black");
		            	} else {
		            		alert("인증번호가 다릅니다. 다시 인증해주세요");
		            		$("#reKey").focus();
		            		$("#findbtn").prop("disabled", true);
		    		        $("#findbtn").css("color", "gray");
		            	}
		        	});
		        },
				error : function(jqXHR, textStatus, errorThrown){
					alert("메일보내기 실패 다시 시도해주세요");
					
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
						<button class="button reser clear" onclick="location.href='login'">로그인</button>
						<button class="button reser payment" onclick="location.href='edit'">확인</button>
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
                     이메일 수정
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
        </div>
       </div>
       
 <!-- 모달 여는 버튼 -->
		<div class="button-box">
            <button class="button reser clear" onclick="location.href='login'">로그인</button>
            <button class="button reser clear" onclick="location.href='edit'">뒤로가기</button>
            <button type="button" id="findbtn" class="btn btn-primary m-3 p-3" data-bs-toggle="modal" data-bs-target="#modal">이메일 변경</button>
		</div>   
	
</body>
</html>
--%>