
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
    <script>
    	//암호화
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
    	
   $(function(){
	   
	var password = RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/); 
	
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
	  });
});
   
</script>

<form method="post">

<div class="container-400 container-center">
	<div class="row center">
		<h2>비밀번호 변경</h2>
	</div>
	<div class="row">
		<label>현재 비밀번호</label>
		<input type="password" name="memberPw" required class="form-input">
	</div>
	
	<div class="pw_wrap">
		<div class="pw_name">변경 비밀번호</div>
		<div class="pw_input_box">
		<input type="password" name="changePw" required id="pw"
		placeholder="특수문자, 영문, 숫자, 6자 이상 20자 이내로 입력하세요" class="pw_input">
		</div>
		<div id="pwComm"></div>
	</div>
	
	<div class="pwck_wrap">
		<div class="pwck_name">비밀번호 확인</div>
		<div class="pwck_input_box">
		<input type="password" name="changePw2" required id="pwch"
		placeholder="비밀번호를 한번 더 입력하세요" class="pwck_input">
		</div>
		<div id="pwComm2"></div>
	</div>
	
	<div class="row">
		<input type="submit" value="변경" class="form-btn">
	</div>

	<c:if test="${param.error != null}">
	<div class="row center">
		<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
</div>

</form>




