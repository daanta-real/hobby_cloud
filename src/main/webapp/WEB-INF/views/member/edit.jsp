<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

    <script>
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
   
   
   $(function(){
		let id = '${memberDto.memberIdx}';
		let social = id.substr(id.indexOf("@"),id.length);
		console.log("dfd :" + social);
		if(social == "@n" || social == "@k") {
			$(".social").hide();
			
		}
		
		let email = '${memberDto.memberEmail}';
		$('input[name="email_id"]').val(email.substr(0,email.indexOf("@")));
		$('input[name="email_domain"]').val(email.substr(email.indexOf("@")+1,email.length));
		
		let phone = '${memberDto.memberPhone}';
		$('input[name="phone1"]').val(phone.substr(0,3));
		$('input[name="phone2"]').val(phone.substr(3,4));
		$('input[name="phone3"]').val(phone.substr(7,4));
		
		
		$("#btnclick").click(function(){
    		let phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
    		$('input[name="phone"]').val(phone);
    	})
		
	})
	
    </script>

<%-- 출력 --%>

<div class="wrapper">
<form method="post" enctype="multipart/form-data" id="join_form">
<div class="wrap">
	<div class="subject">
		<span>회원정보수정</span>
	</div>
	
	<div class="id_wrap">
		<div class="id_name">아이디</div>
		<div class="id_input_box">
		${memberDto.memberId }
		</div>
	</div>

	<div class="pw_wrap">
		<div class="pw_name">비밀번호</div>
		<div class="pw_input_box">
		<input type="password" name="memberPw"  class="pw_input" required
		placeholder="비밀번호를 입력하세요" id="pw">
		</div>
	</div>
	
	<div class="nick_wrap">
		<div class="nick_name">닉네임</div>
		<div class="nick_input_box">
			${memberDto.memberNick}
		</div>
	</div>
	
	<div class="phone_wrap">
		<div class="phone_name">핸드폰 번호</div>
				<input type="text" id="phone1" name="phone1" 
						class="input--text phone" maxlength="3" required
						placeholder="000"> -
					<input type="text" id="phone2" name="phone2" 
						class="input--text phone" maxlength="4" required
						placeholder="0000"> -
					<input type="text" id="phone3" name="phone3" 
						class="input--text phone" maxlength="4" required
						placeholder="0000">	
					<input type="hidden" id="phoneNum" name="phone">
					<div id="phComm"></div>
			<div id="phComm"></div>
	</div>
			
	<div class="region_wrap">
		<div class="region_name">주소</div>
		 	<input type="text" name="memberRegion"  value="${memberDto.memberRegion}" readonly class="address_input" id="region">
		 	<button type="button" class="findRegion">주소 찾기</button>
		 	<div id="regioncheck"></div>
	</div>		
	
	<div class="profile_wrap">
		<div class="profile">프로필 이미지</div>
		<input type="file" name="attach" accept="image/*" class="profile_input">
			<c:choose>
	            <c:when test="${memberProfileDto == null}">
	           		 <img src="https://via.placeholder.com/300x300?text=User">
	            </c:when>
	            <c:otherwise>
	            	<img src="profile?memberIdx=${memberProfileDto.memberIdx}" width="100%">
	          		<a href="profileDelete?memberIdx=${memberProfileDto.memberIdx}">삭제</a>
	            </c:otherwise>
        </c:choose>
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
		${memberDto.memberEmail}
	<input type="button" id="emailCheck" class="adCheck" value="메일변경하기" onclick="location.href='updateMail'">
	</div>
	</div>
	
	<div class="edit_button_wrap">
			<input type="submit" class="edit_button" id="btnclick" value="수정하기">
	</div>
	
</div>
</form>
</div>


<c:if test="${param.error != null}">
<h4><font color="red">비밀번호가 일치하지 않습니다</font></h4>
</c:if>







