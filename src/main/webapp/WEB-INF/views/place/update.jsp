<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
    
<script>
	 
    $(function(){    	
		$("#btnclick").click(function(){
	   		let placePhone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
	   		$('input[name="placePhone"]').val(placePhone);
	   		console.log("합해진 핸드폰 번호 placePhone : " +$("#phone1").val() + $("#phone2").val() + $("#phone3").val());
			alert("실행"+placePhone);
	   			   		
	   		let placeEmail = $("#idMail").val() + "@" + $("#inputMail").val();
	   		$('input[name="placeEmail"]').val(placeEmail);
	   		console.log("이메일 합 : " + $("#idMail").val() + "@" + $("#inputMail").val());
	   		alert("실행"+placeEmail);
		})
	
		   $("#emailBox").change(function() {
	         if ($("#emailBox").val() == "directly") {
	             $("#inputMail").attr("readonly", false);
	             $("#inputMail").val("");
	             $("#inputMail").focus();
	         }  else {
	             $('#inputMail').val($('#emailBox').val());
	             $("#inputMail").attr("readonly", true);
	         }
		   });
    });
    
    /* 주소 검색 모듈 
     *  .find-address-btn을 누르면 자동으로 주소검색창이 나옴
     *  
     *  - input[name=placePostcode] 에 우편번호 작성
     *  - input[name=placeAddress] 에 기본주소 작성
     *  - input[name=placeDetailAddress] 에 커서 이동
     */
    
		 $(function(){
			$(".find-address-btn").click(function(){
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
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.querySelector("input[name=placePostcode]").value = data.zonecode;
		                //$("input[name=postcode]").val(data.zonecode);
		                document.querySelector("input[name=placeAddress]").value = addr;
		                //$("input[name=address]").val(addr);
		                
		                //원래 써있던 값지우기
		            	document.querySelector("input[name=placeDetailAddress]").value = null;
		                // 커서를 상세주소 필드로 이동한다.
		                document.querySelector("input[name=placeDetailAddress]").focus();
		                //$("input[name=detailAddress]").focus();
		            }
		        }).open();
		    };	
		 });
</script>

<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강의장 수정 정보</h1>
	</div>
	<div>
		<label>장소 이름</label>
		<input type="text" name="placeName" >
	</div>
	<div>
	<label>장소 설명</label>
		<input type="text" name="placeDetail" >
	</div>
	<div class="row">
		<label>강의장 용도</label>
			<select id="room" name="roomBox" required>
				<option value="" class="pickRoom">선택하세요</option>
				<option>운동</option>
				<option>요리</option>
				<option>문화</option>
				<option>예술</option>
				<option>IT</option>
				<option value="directly">직접입력</option>
			</select>
	</div>
	<div class="row">
	<div class="region_wrap">
		<label>강의장 주소</label>
		 	<input type="text" name="placePostcode" placeholder="우편번호" readonly id="placePostcode">
			 	<button type="button" id="kakao_Address" class="find-address-btn" value="주소찾기">
			 	주소 찾기
			 	</button>
		<label>강의장 상세주소</label>
			<input type="text" id="placeAddress" name="placeAddress" placeholder="상세 주소" required readonly>
		 <label>강의장 상세주소</label>
			<input type="text" id="placeDetailAddress" name="placeDetailAddress" placeholder="상세 주소">
			<input type="hidden" name="address" >
	</div>
	</div>
	<div class="row">
		<label class="form-block">대여 가능 시작일</label>
		<input type="date" name="placeStart" required class="form-input form-inline">
	</div>
	<div class="row">
		<label class="form-block">대여 가능 종료일</label>
		<input type="date" name="placeEnd" required class="form-input form-inline">
	<div class="row">
		<label>대여희망최소금액</label>
		<input type="number" name="placeMin">
	</div>
	<div class="row">
		<label>대여희망최대금액</label>
		<input type="number" name="placeMax">
	</div>
	
	<div class="row">
		<label class="mail_name">이메일</label>
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
			<input type="hidden" name="placeEmail" class="mail_input" >
		</div>
	</div>
	
	<div class="row">
		<label class="phone_name">핸드폰 번호</label>
		<div class="phone_wrap">
	 			<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone"> -
				<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone"> -
				<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone">	
				<input type="hidden" name="placePhone" id="phoneNum">
		</div>
	</div>
	
	<div class="place_wrap">
		<label class="place_file_name">장소 파일</label>
		<input type="file" name="attach" accept="image/*" class="place_file_input" enctype="multipart/form-data" multiple>
	</div>

	<div class="row">
		<input type="submit" value="수정" class="form-btn" id="btnclick">
	</div>
</div>

</div>	
</form>