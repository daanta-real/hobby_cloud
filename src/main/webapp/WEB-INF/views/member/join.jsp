<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<head>
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
    	 *	 핸드폰 주소, 이메일 문자열 붙여서 전송하기
    	 */
        
     	$("#btnclick").click(function(){
     		
    		let phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
    		$('input[name="phone"]').val(phone);

    		let email = $("#idMail").val() + "@" + $("#inputMail").val();
    		$('input[name="email"]').val(email);
    	})
    	
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
    	
     	/*  
     	 *	 정규식 검사
     	 */
     	 
     	 
      	/*  
      	 *	 중복검사
      	 */
     	function idOverlap() {
     	    var memberId = $("#userId").val();
     	    var sendData = {"memberId" : memberId};
     	    console.log("memberId : " + memberId);
     	    $.ajax({
     	    	type : "post",
     	        url : "idOverlap.do",
     	        data : sendData,
     	        success : function(resp){
     	        	console.log("resp : " + resp);
     	        	if(resp == "fail") {
     		        	$("#idCheck").text("");
     			        $("#idCheck").css("color", "red");
     			        $("#idCheck").html("중복된 아이디입니다.");
     			   
     			        $("#btnclick").prop("disabled", true);
     			        $("#btnclick").css("color", "red");
     	        	} else {
     	        		$("#idCheck").text("");
     	    	        $("#idCheck").css("color", "green");
     	    	        $("#idCheck").html("중복 x 사용가능한 아이디입니다.");
     	    	        
     	    	        $("#btnclick").prop("disabled", false);
     	        	}
     	        }
     	    })
     	    
     	}
     	
      	/*  
      	 *	 이메일 인증
      	 */
      	 
      	function sendMail() {
      		var mailAddr = $("#idMail").val() +"@"+ $("#inputMail").val();
      		$.ajax({
      	    	type : "post",
      	        url : "sendMail.do",
      	        data : {"email" : mailAddr},
      	        success : function(resp){
      	        	alert("메일이 성공적으로 보내졌습니다.  " + resp);
      	        	$("#reKeyCheck").click(function(){
      	        		if(resp == $("#reKey").val()) {
      	        		
      	        			alert("인증이 완료되었습니다.");
      	            		$("#btnclick").prop("disabled", false);
      	    		        $("#btnclick").css("color", "green");
      	            	} else {
      	            		alert("인증번호가 다릅니다. 다시 인증해주세요");
      	            		$("#reKey").focus();
      	            		$("#btnclick").prop("disabled", true);
      	    		        $("#btnclick").css("color", "gray");
      	            	}
      	        	});
      	        },
      			error : function(jqXHR, textStatus, errorThrown){
      				alert("이메일 보내기 실패 다시 시도해주세요");
      				
      			}
      		})
      	}
     	 
    </script>

    
    
<body>

<form action="join" method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>회원가입</h1>
	</div>
	<div class="row">
		<label>아이디</label>
		<input type="text" name="memberId"  id="userId" required
		placeholder="4~12자의 영문소문자, 숫자로만 입력해주세요" >
		<div id="idCheck"></div>
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name="memberPw" id="pwd" required
		placeholder="특수문자, 영문, 숫자 포함 6자 이상 20자 이내로 입력하세요">
		<div id="pwComm"></div>
	</div>
		<div class="row">
		<label>비밀번호 재확인</label>
		<input type="password" name="memberPw2" id="pwdCh" required
		placeholder="특수문자, 영문, 숫자 포함 6자 이상 20자 이내로 입력하세요">
		<div id="pwComm2"></div>
	</div>
	<div class="row">
		<label>닉네임</label>
		<input type="text" name="memberNick" required
		placeholder="이름을 입력해 주세요" maxlength="20">
	</div>	
	<div class="row">
		<label>전화번호</label>
			<input type="text" id="phone1" name="phone1" 
				maxlength="3" required placeholder="000"> -
			<input type="text" id="phone2" name="phone2" 
				maxlength="4" required placeholder="0000"> -
			<input type="text" id="phone3" name="phone3" 
				maxlength="4" required placeholder="0000">	
			<input type="hidden" id="phoneNum" name="phone">
		<div id="phComm"></div>
	</div>
		<div class="row">
		 	<label class="label-text">주소</label>
		 	<input type="text" name="memberRegion" placeholder="주소"  readonly>
		 	<button type="button" class="findRegion">주소 찾기</button>
		 </div>
	<div class="row">
		<label>프로필 이미지</label>
		<input type="file" name="attach" accept="image/*" class="form-input">
	</div>
	<div class="row">
		<label>관심분야</label>
		<input type="checkbox" name="lecCategoryName"  value="sports">스포츠
		<input type="checkbox" name="lecCategoryName"  value="music">음악
		<input type="checkbox" name="lecCategoryName"  value="painting">그림	   		 
	</div>
	<div class="row">
	
	<label>이메일</label>
		<input type="text" id="idMail" name="emailId" required> @
		<input type="text" id="inputMail" name="emailDomain" required readonly>
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
		<input type="hidden" name="email" >
		<div id="mailComm"></div>
	</div>
	<div class="row">
		<input type="text" id="reKey" class="input--text name" maxlength="20" placeholder="인증번호를 입력해주세요" required>
		<input type="button" id="reKeyCheck" class="adCheck" value="확인">
	</div>
	<div class="row">
		<input type="submit" value="가입" id="joinclick" class="form-btn">
	</div>
</div>
	
</form>

</body>



