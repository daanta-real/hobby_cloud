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

window.addEventListener("load", function() {
});	
	/*  
	 *	 주소 검색창
	 *  .findRegion을 누르면 자동으로 주소검색창이 나옴    
	 *  - input[name=memberRegion] 에 기본주소 작성
	 */
//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
    	 $(function(){
   		$(".findRegion").click(function(){
   	    	findAddress();
   	    });
   	    function findAddress(){
   	        new daum.Postcode({
   	            oncomplete: function(data) {
   	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
   	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
   	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
   	                var addr = ""; // 주소 변수
   	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
   	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
   	                if (data.userSelectedType === "R") { // 사용자가 도로명 주소를 선택했을 경우
   	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
   	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
   	                    if(data.bname !== "" && /[동|로|가]$/g.test(data.bname)){
   	                        addr = data.roadAddress + " (" + data.bname + ")";
   	                    }
   	                    else{
   	                        addr = data.roadAddress;
   	                    }
   	                } 
   	                else { // 사용자가 지번 주소를 선택했을 경우(J)
   	                    addr = data.jibunAddress;
   	                }
   	                // 주소 정보를 해당 필드에 넣는다.
   	                document.querySelector("input[name=memberRegion]").value = addr;
   	            }
   	        }).open();
   	    };
   	 });
   	
   	$("#btnclick").click(function() { 
   		alert("Disabled 처리"); 
   		$("#btnclick").prop("disabled", true);
   	});
    	//유효성 검사
    	var code = "";				//이메일전송 인증번호 저장위한 코드
    	
    	//유효성 검사 통과 유무 변수
 		 var idCheck = false;				// 아이디
 		 var pwCheck = false;			// 비밀번호
 		 var pwchCkeck = false;			// 비밀번호 확인
 		 var nickCheck = false;			// 닉네임확인
 		 var mailCheck = false;			// 이메일
 		 var phoneCheck = false;		// 핸드폰번호
 		 var idckCheck = false;			// 아이디중복
 		 var nickckCheck = false 		//닉네임중복
 		 var KeyCheck = false 			//인증번호
 		 
 		  //최종 유효성 검사	  
     	function checkAll() {
     		console.log("최종 유효성 검사 시작");
	         $("#btnclick").prop("disabled", true);
	         $("#btnclick").css("color", "gray");
 	      	//최종 유효성 검사
 	   		if(idCheck&&pwCheck&&pwchCkeck&&nickCheck&&mailCheck&&
 				phoneCheck &&idckCheck&&nickckCheck&&KeyCheck){	
 	   			alert("Disabled 해제 처리");
 	   		 $("#mailComm").html("");
	         $("#btnclick").prop("disabled", false);
 	         $("#btnclick").css("color", "blue");
 	   		}		
 	   		return false;
 	 	};
		 
$(document).ready(function(){
		
		/* 입력값 변수 */
		var addr = $('.address_input').val();		// 주소 입력란
		/* 정규표현식 변수 */
     		var emp = new RegExp(/\s/g)
     	    var userId = new RegExp(/(?=.*\d{1,20})(?=.*[a-zA-Z]{1,20}).{4,16}$/);
     	    var password = new RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/); 
     	    var nick =  new RegExp(/^[0-9a-zA-Z가-힣]{2,10}$/); 
     		var ph = new RegExp(/^[0-9]*$/); 
     		var email_id = new RegExp(/^[a-zA-Z0-9_-]{4,20}$/);
     		var email_domain= new RegExp(/^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/);
     		/* 아이디 유효성검사 */
     	  $("#userId").keyup(function(){
     	      if(!userId.test($("#userId").val())){
     	         console.log("사용불가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "red");
     		         $("#idCheck").html("아이디는 영문, 숫자 4~16자리만 가능합니다.");
 		         	
     		         $("#btnclick").prop("disabled", true);
     		         $("#btnclick").css("color", "gray");
					idCheck = false;
					
     	         } else {
     	        	 console.log("사용가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "green");
     		         $("#idCheck").html("사용가능한 아이디입니다.");
     		         
     		         idOverlap();
     		         $("#btnclick").prop("disabled", false);
     		        
					idCheck = true;
     	         }
     	      
     	     checkAll();
     	  });
     		
  		/* 비밀번호 유효성 검사 */
  		 $("#pw").keyup(function(){
  		      if(!password.test($("#pw").val())){
  		         console.log("사용불가능" + $("#pw").val());
  			         $("#pwComm").text("");
  			         $("#pwComm").css("color", "red");
  			         $("#pwComm").html("영문,숫자,특수문자 8자 이상 16자 이내로 입력하세요");
  			         
  			         pwCheck = false;
  			         $("#btnclick").prop("disabled", true);
  			         $("#btnclick").css("color", "gray");  
  			         
  		         } else {
  		         console.log("사용가능" + $("#pw").val());
		         	 $("#pwComm").text("");
		        	 $("#pwComm").css("color", "green");
  			         $("#pwComm").html("사용가능한 비밀번호입니다.");     
  			              			        
					pwCheck = true;
			         $("#btnclick").prop("disabled", false);
  		         }   
  		    checkAll();
  		  });
	// 비밀번호 동일한지 여부
	 $("#pwch").keyup(function(){
	      if($("#pwch").val() != $("#pw").val()){
		         $("#pwComm2").text("");
		         $("#pwComm2").css("color", "red");
		         $("#pwComm2").html("비밀번호가 동일하지 않습니다.");
		         		         
		         pwchCkeck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
				
	         } else {
		         $("#pwComm2").html("");
		         $(this).prop("disabled",false);     	
		         
		         pwchCkeck = true;
		         $("#btnclick").prop("disabled", false);
	         } 
	      checkAll();
	  });
		
		/* 닉네임 유효성 검사 */
     	  $("#userNick").keyup(function(){
     	      if(!nick.test($("#userNick").val())){
     	         console.log("사용불가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "red");
     		         $("#nickCheck").html("닉네임은 대소문자, 한글 숫자로 이루어진 2~10자리만 가능합니다.");
     		         
					nickCheck = false;
			         $("#btnclick").prop("disabled", true);
			         $("#btnclick").css("color", "gray");
					
     	         } else {
     	        	 console.log("사용가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "green");
     		         $("#nickCheck").html("사용가능한 닉네임입니다.");
     		         
     		        nickOverlap();
     		        
					nickCheck = true;
			         $("#btnclick").prop("disabled", false);
     	         }
     	     checkAll();
     	  });
		
	// 이메일 아이디 유효성 검사
	 $("#idMail").keyup(function(){
	      if(!email_id.test($("#idMail").val())){
		         $("#mailComm").text("");
		         $("#mailComm").css("color", "red");
		         $("#mailComm").html("이메일 형식이 맞지 않습니다.");
		         
				mailCheck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
			
	         } else {
	        	 $("#mailComm").html("");
	        	 
				mailCheck = true;
		         $("#btnclick").prop("disabled", false);
	         }
	      checkAll();
	  });
	
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
		                    
		       	         $("#btnclick").prop("disabled", true);
		    	         $("#btnclick").css("color", "gray");
                     } else {
                         $("#mailComm").html("");
            	         $("#btnclick").prop("disabled", false);                    
                     }
                  });
         }  else {
             $('#inputMail').val($('#emailBox').val());
             $("#inputMail").attr("readonly", true);
         }
         checkAll();
     });
	
    $("#emailCheck").click(function(){
     	console.log("이메일 인증 id : " + $("#idMail").val());
     	console.log("이메일 인증 domain : " + $("#inputMail").val());
     	console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
     	
     	sendMail();
     });
    
    $("#reKey").keyup(function(){
    	$("#btnclick").css("color", "gray");
    	$("#btnclick").prop("disabled", true);
    });     
	// 폰번호 유효성 검사
	 $(".phone").keyup(function(){
	      if(!ph.test($(this).val())){
		         $("#phComm").text("");
		         $("#phComm").css("color", "red");
		         $("#phComm").html("숫자만 입력해주세요");
		         
				phoneCheck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
				
	         } else {
	        	 $("#phComm").html("");
	        	 
				phoneCheck = true;
		         $("#btnclick").prop("disabled", false);
	         }
	      checkAll();
	  });		
	
/* 	// 주소 유효성 검사
	 $("#region").keyup(function(){
	      if($("#region").val() ==""){
		         $("#regioncheck").text("");
		         $("#regioncheck").css("color", "red");
		         $("#regioncheck").html("주소를 입력해주세요");
		         
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
		         addressCheck = false;
	         } else {
		         $("#regioncheck").html("");
		         $("#btnclick").prop("disabled", false);
		         addressCheck = true;
	         }   
	  }); */
		
		// 핸드폰번호 , 이메일 문자열 붙여서 전송하기
	       
    	$("#btnclick").click(function(){
    		
	   		let memberPhone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
	   		$('input[name="memberPhone"]').val(memberPhone);
	   		console.log("합해진 핸드폰 번호 memberPhone : " +$("#phone1").val() + $("#phone2").val() + $("#phone3").val());
	   			   		
	   		let email = $("#idMail").val() + "@" + $("#inputMail").val();
	   		$('input[name="memberEmail"]').val(email);
	   		console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
   	})
	
});   	
 		 
 	//아이디 중복검사
 	function idOverlap(){
 			
 		//입력되는 값 userId
 		var memberId = $("#userId").val();
 		
 		//컨트롤러에 넘길 데이터의 이름
 		var data = {"memberId" : memberId};	
 		console.log("memberId : " + memberId);
 		
 		$.ajax({
 			type : "post",
 			url : "memberIdChk",
 			data : data,
 			success : function(result){
 			 console.log("성공 여부" + result);
 				if(result == 'fail'){
 		        	$("#idCheck").text("");
 			        $("#idCheck").css("color", "red");
 			        $("#idCheck").html("중복된 아이디입니다.");
 			        
 					idckCheck = false;
			         $("#btnclick").prop("disabled", false);		         
 					
 				} else {
 	        		$("#idCheck").text("");
 	    	        $("#idCheck").css("color", "green");
 	    	        $("#idCheck").html("사용가능한 아이디입니다.");
 			         
  					idckCheck = true;
			         $("#btnclick").prop("disabled", true);
 	        	}
 				checkAll();
 	        }
 	    })
 	}
	   	//닉네임 중복검사
	   	function nickOverlap(){
	    		
	   		//입력되는 값 userNick
	   		var memberNick = $("#userNick").val();
	   		
	   		//컨트롤러에 넘길 데이터의 이름
	   		var data = {"memberNick" : memberNick};	
	   		console.log("memberNick : " + memberNick);
		   		
	   		$.ajax({
	   			type : "post",
	   			url : "memberNickChk",
	   			data : data,
	   			success : function(result){
	   			 console.log("성공 여부" + result);
	   				if(result == 'fail'){
	   		        	$("#nickCheck").text("");
	   			        $("#nickCheck").css("color", "red");
	   			        $("#nickCheck").html("중복된 닉네임입니다.");	
	 			        
	   			     	nickckCheck = false;
	   			     	$("#btnclick").prop("disabled", false);
	   					
	   					
	   				} else {
	   	        		$("#nickCheck").text("");
	   	    	        $("#nickCheck").css("color", "green");
	   	    	        $("#nickCheck").html("사용가능한 닉네임입니다.");
	   	    	        
	   	    	     	nickckCheck = true;
	   		         	$("#btnclick").prop("disabled", true);
	   		        	$("#btnclick").css("color", "gray");
	   	        	}
	   				checkAll();
	   	        }
	   	    }) 
	   	}
		
	  //인증 메일
	   	function sendMail() {
	   		var mailAddr = $("#idMail").val() +"@"+ $("#inputMail").val();
	   		$.ajax({
	   	    	type : "post",
	   	        url : "sendMail",
	   	        data : {"email" : mailAddr},
	   	        success : function(resp){
	   	        	alert("메일이 성공적으로 보내졌습니다.  " + resp);
	   	        	$("#reKeyCheck").click(function(){
	   	        		if(resp == $("#reKey").val()) {
	   	        		
	   	        			alert("인증이 완료되었습니다.");
	   	        			
	   	        			KeyCheck = true;
	   	        			$("#btnclick").prop("disabled", false);
	   	    		        $("#btnclick").css("color", "green");
	   	   	 	         	$("#btnclick").prop("disabled", false);
	   	   	 	    		$("#btnclick").css("color", "white");
	   	        			
	   	            	} else {
	   	            		alert("인증번호가 다릅니다. 다시 인증해주세요");
	   	            		$("#reKey").focus();
	   	            		
	   	            		KeyCheck = false;
	   	            		$("#btnclick").prop("disabled", true);
	   	    	      		$("#btnclick").css("color", "gray");
	   	            	}
	   	        		checkAll();
	   	        	});
	   	        },
	   			error : function(jqXHR, textStatus, errorThrown){
	   				alert("이메일 보내기 실패 다시 시도해주세요");	   				
	   			}
	   		})
	   	}	  
	   

</script>


</HEAD>
<BODY>
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
			회원가입
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
			
	
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form name="searchForm" method="post" class="row" enctype="multipart/form-data" id="join_form">
					<div class="form-group col-12">
						<label for="searchForm_memberId" class="form-label mb-0 id_input">아이디</label>
						<input name="memberId" id="searchForm_memberId userId" type="text" class="form-control" placeholder="4~12자의 영문소문자, 숫자로만 입력해주세요" value="">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
						<div id="idCheck"></div>
					</div>
					<div class="form-group col-12">
						<label for="searchForm_memberNick" class="form-label mb-0">비밀번호</label>
						<input name="memberPw" id="searchForm_memberNick pw" type="password" class="form-control" placeholder="특수문자, 영문, 숫자, 6자 이상 20자 이내로 입력하세요" value="}">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group col-12">
						<label for="searchForm_memberNick" class="form-label mb-0">비밀번호확인</label>
						<input name="memberPw2" id="searchForm_memberNick pwch" type="password" class="form-control" placeholder="비밀번호를 한번 더 입력하세요" value="">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group col-12">
						<label for="searchForm_memberNick" class="form-label mb-0">닉네임</label>
						<input name="memberNick" id="searchForm_memberNick userNick" type="text" class="form-control" placeholder="닉네임을 입력하세요" value="">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group mb-4 col-md-6 container">
						
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
				<div class="row mb-4">
      				<legend for="joinForm_gender" class="form-label mb-0">성별</legend>
       				<div class="input-group flex-nowrap grayInputGroup p-0">
	      				<div class="joinForm_genderMan"> 
	          				<input type="radio" class="form-check-input" name="memberGender" id="optionsRadios1" value="남" checked="">
	         					남성
	     				</div>
	     				<div class="joinForm_genderWoman">
	     				<div>
	          					<input type="radio" class="form-check-input" name="memberGender" id="optionsRadios2" value="여" >
	         					여성
	     				</div>
	     				</div>
	     			</div>
	     		</div>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="memberGender" id="optionsRadios2" value="여">
          여성
        </label>
      </div>
      <div class="form-group col-12">
						<label for="searchForm_memberNick" class="form-label mb-0">핸드폰 번호</label>
						
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
						<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone form-control""> -
			<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone form-control""> -
			<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone form-control"">	
			<input type="hidden" name="memberPhone" id="phoneNum">
			<div id="phComm"></div>
					</div>
		<div class="region_wrap">
		<div class="region_name"></div>
		 	<label for="searchForm_memberNick" class="form-label mb-0">주소</label>
						<input name="memberRegion" id="searchForm_memberNick" type="text" class="form-control" placeholder="주소" value="">
		 	<button type="button" class="btn btn-outline-primary mt-1 findRegion">주소 찾기</button>
		 	<div id="regioncheck"></div>
	</div>	
	<div class="form-group justify-content-center">
      <label for="formFile" class="form-label">프로필사진</label>
      <input class="form-control" type="file" id="formFile" name="attach" enctype="multipart/form-data" multiple>
    </div>
   	<div class="row mb-4">
			<label>카테고리</label>
				<select name="lecCategoryName" required class="form-input p-1 border-radius-all-25">
					<option value="" class="">선택하세요</option>
					<option value="운동">운동</option>
					<option value="요리">요리</option>
					<option value="문화">문화</option>
					<option value="예술">예술</option>
					<option value="IT">IT</option>
					<option value="directly">직접입력</option>														
				</select>
	</div>
        <%--이메일?
        <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">이메일</label>
      <input type="email" name="email_id" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted"></small>
    </div>
       @
    <div class="form-group">
     <input type="email" name="email_domain"class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted"></small>
    </div>
    <div class="form-group">
     <input type="email" name="email_id" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted"></small>
    </div>--%>
    <div class="mail_wrap">
 	<div class="mail_name">이메일</div>
 	<div class="mail_input_box"> 
		<input type="text" id="idMail" name="email_id"  required> @
		<input type="text" id="inputMail" name="email_domain" required readonly>
		<select id="emailBox" name="emailBox" required>
			<option value="" class="pickMail">이메일 선택</option>
			<option value="directly">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="daum.net">daum.net</option>
			<option value="hanmail.net">hanmail.net</option>
			<option value="nate.com">nate.com</option>
		</select>
		<button type="button" class="btn btn-outline-primary mt-1 btn-sm" value="인증하기" >인증하기</button>
		<input type="hidden" name="memberEmail" class="mail_input" >
		<div id="mailComm"></div>
		
		<div class="mail_check_wrap">
			<div>
				<input type="text" id="reKey" class="input--text name" maxlength="20" placeholder="인증번호를 입력해주세요" required>
				<button type="button" class="btn btn-outline-primary mt-1 btn-sm" value="인증하기" >인증하기</button>
			</div>
		</div>
	</div>
</div>
    
	 
       
		 
					
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8" id="btnclick">가입</button>
					</div>
				</form>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

<script>
//비밀번호 암호화        
  	$(function(){
   		$("form").submit(function(e){
   			e.preventDefault();
   			
   			$(this).find("input[type=password]").each(function(){
   				var origin = $(this).val();
   				var hash = CryptoJS.SHA1(origin);
   				var encrypt = CryptoJS.enc.Hex.stringify(hash);
   				$(this).val(encrypt);
   			});
   			
   			this.submit();
   		});
   	});
    	
   	/*  
   	 *	 주소 검색창
   	 *  .findRegion을 누르면 자동으로 주소검색창이 나옴    
   	 *  - input[name=memberRegion] 에 기본주소 작성
   	 */
   	 
    	  
   	 $(function(){
   		$(".findRegion").click(function(){
   	    	findAddress();
   	    });
   	    function findAddress(){
   	        new daum.Postcode({
   	            oncomplete: function(data) {
   	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
   	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
   	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
   	                var addr = ""; // 주소 변수
   	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
   	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
   	                if (data.userSelectedType === "R") { // 사용자가 도로명 주소를 선택했을 경우
   	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
   	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
   	                    if(data.bname !== "" && /[동|로|가]$/g.test(data.bname)){
   	                        addr = data.roadAddress + " (" + data.bname + ")";
   	                    }
   	                    else{
   	                        addr = data.roadAddress;
   	                    }
   	                } 
   	                else { // 사용자가 지번 주소를 선택했을 경우(J)
   	                    addr = data.jibunAddress;
   	                }
   	                // 주소 정보를 해당 필드에 넣는다.
   	                document.querySelector("input[name=memberRegion]").value = addr;
   	            }
   	        }).open();
   	    };
   	 });
   	
   	$("#btnclick").click(function() { 
   		alert("Disabled 처리"); 
   		$("#btnclick").prop("disabled", true);
   	});

    	//유효성 검사
    	var code = "";				//이메일전송 인증번호 저장위한 코드
    	
    	//유효성 검사 통과 유무 변수
 		 var idCheck = false;				// 아이디
 		 var pwCheck = false;			// 비밀번호
 		 var pwchCkeck = false;			// 비밀번호 확인
 		 var nickCheck = false;			// 닉네임확인
 		 var mailCheck = false;			// 이메일
 		 var phoneCheck = false;		// 핸드폰번호
 		 var idckCheck = false;			// 아이디중복
 		 var nickckCheck = false 		//닉네임중복
 		 var KeyCheck = false 			//인증번호
 		 
 		  //최종 유효성 검사	  
     	function checkAll() {
     		console.log("최종 유효성 검사 시작");
	         $("#btnclick").prop("disabled", true);
	         $("#btnclick").css("color", "gray");
 	      	//최종 유효성 검사
 	   		if(idCheck&&pwCheck&&pwchCkeck&&nickCheck&&mailCheck&&
 				phoneCheck &&idckCheck&&nickckCheck&&KeyCheck){	
 	   			alert("Disabled 해제 처리");
 	   		 $("#mailComm").html("");
	         $("#btnclick").prop("disabled", false);
 	         $("#btnclick").css("color", "blue");
 	   		}		
 	   		return false;
 	 	};
		 
$(document).ready(function(){
		
		/* 입력값 변수 */
		var addr = $('.address_input').val();		// 주소 입력란

		/* 정규표현식 변수 */
     		var emp = new RegExp(/\s/g)
     	    var userId = new RegExp(/(?=.*\d{1,20})(?=.*[a-zA-Z]{1,20}).{4,16}$/);
     	    var password = new RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/); 
     	    var nick =  new RegExp(/^[0-9a-zA-Z가-힣]{2,10}$/); 
     		var ph = new RegExp(/^[0-9]*$/); 
     		var email_id = new RegExp(/^[a-zA-Z0-9_-]{4,20}$/);
     		var email_domain= new RegExp(/^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/);

     		/* 아이디 유효성검사 */
     	  $("#userId").keyup(function(){
     	      if(!userId.test($("#userId").val())){
     	         console.log("사용불가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "red");
     		         $("#idCheck").html("아이디는 영문, 숫자 4~16자리만 가능합니다.");
 		         	
     		         $("#btnclick").prop("disabled", true);
     		         $("#btnclick").css("color", "gray");
					idCheck = false;
					
     	         } else {
     	        	 console.log("사용가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "green");
     		         $("#idCheck").html("사용가능한 아이디입니다.");
     		         
     		         idOverlap();
     		         $("#btnclick").prop("disabled", false);
     		        
					idCheck = true;
     	         }
     	      
     	     checkAll();
     	  });
     		
  		/* 비밀번호 유효성 검사 */
  		 $("#pw").keyup(function(){
  		      if(!password.test($("#pw").val())){
  		         console.log("사용불가능" + $("#pw").val());
  			         $("#pwComm").text("");
  			         $("#pwComm").css("color", "red");
  			         $("#pwComm").html("영문,숫자,특수문자 8자 이상 16자 이내로 입력하세요");
  			         
  			         pwCheck = false;
  			         $("#btnclick").prop("disabled", true);
  			         $("#btnclick").css("color", "gray");  
  			         
  		         } else {
  		         console.log("사용가능" + $("#pw").val());
		         	 $("#pwComm").text("");
		        	 $("#pwComm").css("color", "green");
  			         $("#pwComm").html("사용가능한 비밀번호입니다.");     
  			              			        
					pwCheck = true;
			         $("#btnclick").prop("disabled", false);
  		         }   
  		    checkAll();
  		  });

	// 비밀번호 동일한지 여부
	 $("#pwch").keyup(function(){
	      if($("#pwch").val() != $("#pw").val()){
		         $("#pwComm2").text("");
		         $("#pwComm2").css("color", "red");
		         $("#pwComm2").html("비밀번호가 동일하지 않습니다.");
		         		         
		         pwchCkeck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
				
	         } else {
		         $("#pwComm2").html("");
		         $(this).prop("disabled",false);     	
		         
		         pwchCkeck = true;
		         $("#btnclick").prop("disabled", false);
	         } 
	      checkAll();
	  });
		
		/* 닉네임 유효성 검사 */
     	  $("#userNick").keyup(function(){
     	      if(!nick.test($("#userNick").val())){
     	         console.log("사용불가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "red");
     		         $("#nickCheck").html("닉네임은 대소문자, 한글 숫자로 이루어진 2~10자리만 가능합니다.");
     		         
					nickCheck = false;
			         $("#btnclick").prop("disabled", true);
			         $("#btnclick").css("color", "gray");
					
     	         } else {
     	        	 console.log("사용가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "green");
     		         $("#nickCheck").html("사용가능한 닉네임입니다.");
     		         
     		        nickOverlap();
     		        
					nickCheck = true;
			         $("#btnclick").prop("disabled", false);
     	         }
     	     checkAll();
     	  });
		
	// 이메일 아이디 유효성 검사
	 $("#idMail").keyup(function(){
	      if(!email_id.test($("#idMail").val())){
		         $("#mailComm").text("");
		         $("#mailComm").css("color", "red");
		         $("#mailComm").html("이메일 형식이 맞지 않습니다.");
		         
				mailCheck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
			
	         } else {
	        	 $("#mailComm").html("");
	        	 
				mailCheck = true;
		         $("#btnclick").prop("disabled", false);
	         }
	      checkAll();
	  });
	
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
		                    
		       	         $("#btnclick").prop("disabled", true);
		    	         $("#btnclick").css("color", "gray");
                     } else {
                         $("#mailComm").html("");
            	         $("#btnclick").prop("disabled", false);                    
                     }
                  });
         }  else {
             $('#inputMail').val($('#emailBox').val());
             $("#inputMail").attr("readonly", true);
         }
         checkAll();
     });
	

    $("#emailCheck").click(function(){
     	console.log("이메일 인증 id : " + $("#idMail").val());
     	console.log("이메일 인증 domain : " + $("#inputMail").val());
     	console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
     	
     	sendMail();
     });
    
    $("#reKey").keyup(function(){
    	$("#btnclick").css("color", "gray");
    	$("#btnclick").prop("disabled", true);
    });     

	// 폰번호 유효성 검사
	 $(".phone").keyup(function(){
	      if(!ph.test($(this).val())){
		         $("#phComm").text("");
		         $("#phComm").css("color", "red");
		         $("#phComm").html("숫자만 입력해주세요");
		         
				phoneCheck = false;
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
				
	         } else {
	        	 $("#phComm").html("");
	        	 
				phoneCheck = true;
		         $("#btnclick").prop("disabled", false);
	         }
	      checkAll();
	  });		
	
/* 	// 주소 유효성 검사
	 $("#region").keyup(function(){
	      if($("#region").val() ==""){
		         $("#regioncheck").text("");
		         $("#regioncheck").css("color", "red");
		         $("#regioncheck").html("주소를 입력해주세요");
		         
		         $("#btnclick").prop("disabled", true);
		         $("#btnclick").css("color", "gray");
		         addressCheck = false;
	         } else {
		         $("#regioncheck").html("");
		         $("#btnclick").prop("disabled", false);
		         addressCheck = true;
	         }   
	  }); */
		
		// 핸드폰번호 , 이메일 문자열 붙여서 전송하기
	       
    	$("#btnclick").click(function(){
    		
	   		let memberPhone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
	   		$('input[name="memberPhone"]').val(memberPhone);
	   		console.log("합해진 핸드폰 번호 memberPhone : " +$("#phone1").val() + $("#phone2").val() + $("#phone3").val());
	   			   		
	   		let email = $("#idMail").val() + "@" + $("#inputMail").val();
	   		$('input[name="memberEmail"]').val(email);
	   		console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
   	})
	
});   	
 		 
 	//아이디 중복검사
 	function idOverlap(){
 			
 		//입력되는 값 userId
 		var memberId = $("#userId").val();
 		
 		//컨트롤러에 넘길 데이터의 이름
 		var data = {"memberId" : memberId};	
 		console.log("memberId : " + memberId);
 		
 		$.ajax({
 			type : "post",
 			url : "memberIdChk",
 			data : data,
 			success : function(result){
 			 console.log("성공 여부" + result);
 				if(result == 'fail'){
 		        	$("#idCheck").text("");
 			        $("#idCheck").css("color", "red");
 			        $("#idCheck").html("중복된 아이디입니다.");
 			        
 					idckCheck = false;
			         $("#btnclick").prop("disabled", false);		         
 					
 				} else {
 	        		$("#idCheck").text("");
 	    	        $("#idCheck").css("color", "green");
 	    	        $("#idCheck").html("사용가능한 아이디입니다.");
 			         
  					idckCheck = true;
			         $("#btnclick").prop("disabled", true);
 	        	}
 				checkAll();
 	        }
 	    })
 	}
	   	//닉네임 중복검사
	   	function nickOverlap(){
	    		
	   		//입력되는 값 userNick
	   		var memberNick = $("#userNick").val();
	   		
	   		//컨트롤러에 넘길 데이터의 이름
	   		var data = {"memberNick" : memberNick};	
	   		console.log("memberNick : " + memberNick);
		   		
	   		$.ajax({
	   			type : "post",
	   			url : "memberNickChk",
	   			data : data,
	   			success : function(result){
	   			 console.log("성공 여부" + result);
	   				if(result == 'fail'){
	   		        	$("#nickCheck").text("");
	   			        $("#nickCheck").css("color", "red");
	   			        $("#nickCheck").html("중복된 닉네임입니다.");	
	 			        
	   			     	nickckCheck = false;
	   			     	$("#btnclick").prop("disabled", false);
	   					
	   					
	   				} else {
	   	        		$("#nickCheck").text("");
	   	    	        $("#nickCheck").css("color", "green");
	   	    	        $("#nickCheck").html("사용가능한 닉네임입니다.");
	   	    	        
	   	    	     	nickckCheck = true;
	   		         	$("#btnclick").prop("disabled", true);
	   		        	$("#btnclick").css("color", "gray");
	   	        	}
	   				checkAll();
	   	        }
	   	    }) 
	   	}
		
	  //인증 메일
	   	function sendMail() {
	   		var mailAddr = $("#idMail").val() +"@"+ $("#inputMail").val();
	   		$.ajax({
	   	    	type : "post",
	   	        url : "sendMail",
	   	        data : {"email" : mailAddr},
	   	        success : function(resp){
	   	        	alert("메일이 성공적으로 보내졌습니다.  " + resp);
	   	        	$("#reKeyCheck").click(function(){
	   	        		if(resp == $("#reKey").val()) {
	   	        		
	   	        			alert("인증이 완료되었습니다.");
	   	        			
	   	        			KeyCheck = true;
	   	        			$("#btnclick").prop("disabled", false);
	   	    		        $("#btnclick").css("color", "green");
	   	   	 	         	$("#btnclick").prop("disabled", false);
	   	   	 	    		$("#btnclick").css("color", "white");
	   	        			
	   	            	} else {
	   	            		alert("인증번호가 다릅니다. 다시 인증해주세요");
	   	            		$("#reKey").focus();
	   	            		
	   	            		KeyCheck = false;
	   	            		$("#btnclick").prop("disabled", true);
	   	    	      		$("#btnclick").css("color", "gray");
	   	            	}
	   	        		checkAll();
	   	        	});
	   	        },
	   			error : function(jqXHR, textStatus, errorThrown){
	   				alert("이메일 보내기 실패 다시 시도해주세요");	   				
	   			}
	   		})
	   	}
   
</script>

<div class="wrapper">
<form method="post" enctype="multipart/form-data" id="join_form">
<div class="wrap">
	<div class="subject">
		<span>회원가입</span>
	</div>
	
	<div class="id_wrap">
		<div class="id_name">아이디</div>
		<div class="id_input_box">
		<input type="text" class="id_input" name="memberId" required
		placeholder="4~12자의 영문소문자, 숫자로만 입력해주세요" id="userId" >
		<div id="idCheck"></div>
		</div>
	</div>
	
	<div class="pw_wrap">
		<div class="pw_name">비밀번호</div>
		<div class="pw_input_box">
		<input type="password" name="memberPw"  class="pw_input" required
		placeholder="특수문자, 영문, 숫자, 6자 이상 20자 이내로 입력하세요" id="pw">
		</div>
		<div id="pwComm"></div>
	</div>
	
	<div class="pwck_wrap">
		<div class="pwck_name">비밀번호 확인</div>
		<div class="pwck_input_box">
		<input type="password" name="memberPw2" required id="pwch"
		placeholder="비밀번호를 한번 더 입력하세요" class="pwck_input">
		</div>
		<div id="pwComm2"></div>
	</div>
	
	<div class="nick_wrap">
		<div class="nick_name">닉네임</div>
		<div class="nick_input_box">
		<input type="text" name="memberNick" required class="nick_input" maxlength=10 
		placeholder="닉네임은 대소문자, 한글 숫자 2~10자리 이내로 입력하세요" id="userNick">
		<div id="nickCheck"></div>
		</div>
	</div>
	
	<div class="gender_wrap">
		<div class="gender_name">성별</div>
		<input type="radio" class="memberGender" name="memberGender" value="남" checked>남성
		<input type="radio" class="memberGender" name="memberGender" value="여">여성
	</div>
	
	<div class="phone_wrap">
		<div class="phone_name">핸드폰 번호</div>
 			<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone"> -
			<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone"> -
			<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone">	
			<input type="hidden" name="memberPhone" id="phoneNum">
			<div id="phComm"></div>
	</div>
	
	<div class="region_wrap">
		<div class="region_name">주소</div>
		 	<input type="text" name="memberRegion" placeholder="주소" readonly class="address_input" id="region">
		 	<button type="button" class="findRegion">주소 찾기</button>
		 	<div id="regioncheck"></div>
	</div>		 
		 
	<div class="profile_wrap">
		<div class="profile_name">프로필 파일</div>
		<input type="file" name="attach" accept="image/*" class="profile_input">
	</div>
	
	<div class="lecCategory_wrap">
		<div class="lecCategory_name">관심분야</div>
		<input type="checkbox" name="lecCategoryName"  value="운동">운동
		<input type="checkbox" name="lecCategoryName"  value="음악">음악
		<input type="checkbox" name="lecCategoryName"  value="미술">미술	   		 
	</div>

<div class="mail_wrap">
 	<div class="mail_name">이메일</div>
 	<div class="mail_input_box"> 
		<input type="text" id="idMail" name="email_id" class="rowChk" required> @
		<input type="text" id="inputMail" name="email_domain" required readonly>
		<select id="emailBox" name="emailBox" required>
			<option value="" class="pickMail">이메일 선택</option>
			<option value="directly">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="daum.net">daum.net</option>
			<option value="hanmail.net">hanmail.net</option>
			<option value="nate.com">nate.com</option>
		</select>
		<input type="button" id="emailCheck" class="adCheck" value="인증하기">
		<input type="hidden" name="memberEmail" class="mail_input" >
		<div id="mailComm"></div>
		
		<div class="mail_check_wrap">
			<div>
				<input type="text" id="reKey" class="input--text name" maxlength="20" placeholder="인증번호를 입력해주세요" required>
				<input type="button" id="reKeyCheck" class="adCheck" value="확인">
			</div>
		</div>
	</div>
</div>

	<div class="join_button_wrap">
			<input type="submit" class="join_button" id="btnclick" value="가입">
	</div>

</div>
	
</form>

</div>
--%>