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
   	
    	//유효성 검사
    	var code = "";				//이메일전송 인증번호 저장위한 코드
    	
    	//유효성 검사 통과 유무 변수
 		 var idCheck = false;			// 아이디
 		 var idckCheck = false;			// 아이디 중복 검사
 		 var pwCheck = false;			// 비번
 		 var pwckCheck = false;			// 비번 확인
 		 var pwckcorCheck = false;		// 비번 확인 일치 확인
 		 var nickCheck = false;			// 닉네임
 		 var mailCheck = false;			// 이메일
 		 var mailnumCheck = false;		// 이메일 인증번호 확인
 		 var addressCheck = false 		// 주소
		 
$(document).ready(function(){
		
		/* 입력값 변수 */
		var addr = $('.address_input').val();		// 주소 입력란

		/* 정규표현식 변수 */
     		var emp = RegExp(/\s/g)
     	    var userId = RegExp(/(?=.*\d{1,20})(?=.*[a-zA-Z]{1,20}).{4,16}$/);
     	    var password = RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/); 
     	    var nick =  RegExp(/^[0-9a-zA-Z가-힣]{2,10}$/); 
     		var ph = RegExp(/^[0-9]*$/); 
     		var email_id = RegExp(/^[a-zA-Z0-9_-]{4,20}$/);
     		var email_domain= RegExp(/^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/);

     		/* 아이디 유효성검사 */
     	  $("#userId").keyup(function(){
     	      if(!userId.test($("#userId").val())){
     	         console.log("사용불가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "red");
     		         $("#idCheck").html("아이디는 영문, 숫자 4~16자리만 가능합니다.");
     		         
					idCheck = false;
					
     	         } else {
     	        	 console.log("사용가능" + $("#userId").val());
     		         $("#idCheck").text("");
     		         $("#idCheck").css("color", "green");
     		         $("#idCheck").html("사용가능한 아이디입니다.");
     		         
     		         idOverlap();
     		        
					idCheck = true;
     	         }
     	  });
     		
  		/* 비밀번호 유효성 검사 */
  		 $("#pw").keyup(function(){
  		      if(!password.test($("#pw").val())){
  		         console.log("사용불가능" + $("#pw").val());
  			         $("#pwComm").text("");
  			         $("#pwComm").css("color", "red");
  			         $("#pwComm").html("영문,숫자,특수문자 8자 이상 16자 이내로 입력하세요");
  			         
  			         pwCheck = false;
  			         
  		         } else {
  		         console.log("사용가능" + $("#pw").val());
  			         $("#pwComm").text("");
  			         $("#pwComm").css("color", "green");
  			         $("#pwComm").html("사용가능한 비밀번호입니다.");     
  			              			        
					pwCheck = true;
  		         }   
  		  });

	// 비밀번호 동일한지 여부
	 $("#pwch").keyup(function(){
	      if($("#pwch").val() != $("#pw").val()){
		         $("#pwComm2").text("");
		         $("#pwComm2").css("color", "red");
		         $("#pwComm2").html("비밀번호가 동일하지 않습니다.");
		         		         
		         pwchCkeck = false;
				
	         } else {
		         $("#pwComm2").html("");
		         
		         pwchCkeck = true;
	         }   
	  });
		
		/* 닉네임 유효성 검사 */
     	  $("#userNick").keyup(function(){
     	      if(!nick.test($("#userNick").val())){
     	         console.log("사용불가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "red");
     		         $("#nickCheck").html("닉네임은 대소문자, 한글 숫자로 이루어진 2~10자리만 가능합니다.");
     		         
					nickCheck = false;
					
     	         } else {
     	        	 console.log("사용가능" + $("#userNick").val());
     		         $("#nickCheck").text("");
     		         $("#nickCheck").css("color", "green");
     		         $("#nickCheck").html("사용가능한 닉네임입니다.");
     		         
     		        nickOverlap();
     		        
					nickCheck = true;
     	         }
     	  });
		
	// 이메일 아이디 유효성 검사
	 $("#idMail").keyup(function(){
	      if(!email_id.test($("#idMail").val())){
		         $("#mailComm").text("");
		         $("#mailComm").css("color", "red");
		         $("#mailComm").html("이메일 형식이 맞지 않습니다.");
		         
				mailCheck = false;
			
	         } else {
	        	 $("#mailComm").html("");
	        	 
				mailCheck = true;
	         }
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
	
	
    $("#emailCheck").click(function(){
     	console.log("이메일 인증 id : " + $("#idMail").val());
     	console.log("이메일 인증 domain : " + $("#inputMail").val());
     	console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
     	
     	sendMail();
     });       
     

	// 폰번호 유효성 검사
	 $(".phone").keyup(function(){
	      if(!ph.test($(this).val())){
		         $("#phComm").text("");
		         $("#phComm").css("color", "red");
		         $("#phComm").html("숫자만 입력해주세요");
		         
				phoneCheck = false;
				
	         } else {
	        	 $("#phComm").html("");
	        	 
				phoneCheck = true;
	         }
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
   	
	$("#btnclick").click(function(){	
	      	//최종 유효성 검사
	   		if(idCheck&&idckCheck&&pwCheck&&pwchCkeck&&nickCheck&&nickckCheck&&
	   			mailCheck&&mailBoxCheck&&phoneCheck &&nickCheck&&mailCheck){
	   			
	   			$("#btnclick").prop("disabled", false);
	   		}		
	   		return false;
	 	});
	
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
 			        
 					idckCheck = true;
 					
 				} else {
 	        		$("#idCheck").text("");
 	    	        $("#idCheck").css("color", "green");
 	    	        $("#idCheck").html("사용가능한 아이디입니다.");

 					idckCheck = false;
 	        	}
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
	 			        
	   					nickckCheck = true;
	   					
	   				} else {
	   	        		$("#nickCheck").text("");
	   	    	        $("#nickCheck").css("color", "green");
	   	    	        $("#nickCheck").html("사용가능한 닉네임입니다.");
	   	    	        
	   	    	     	nickckCheck = false;
	   	        	}
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
	   	        			
	   	        			mailCheck = true;
	   	            	} else {
	   	            		alert("인증번호가 다릅니다. 다시 인증해주세요");
	   	            		$("#reKey").focus();
	   	            		
	   	            		mailCheck = false;
	   	            	}
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
		<input type="checkbox" name="lecCategoryName"  value="sports">스포츠
		<input type="checkbox" name="lecCategoryName"  value="music">음악
		<input type="checkbox" name="lecCategoryName"  value="painting">그림	   		 
	</div>

<div class="mail_wrap">
 	<div class="mail_name">이메일</div>
 	<div class="mail_input_box"> 
		<input type="text" id="idMail" name="email_id" required> @
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
			<input type="button" class="join_button" id="btnclick" value="가입하기" disabled>
	</div>

</div>
	
</form>

</div>
