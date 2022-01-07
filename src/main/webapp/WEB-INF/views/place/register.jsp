<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
	/*  
	 *	 주소 검색창
	 *  .findRegion을 누르면 자동으로 주소검색창이 나옴    
	 *  - input[name=memberRegion] 에 기본주소 작성
	 */
	 
		function kakaoAddress() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var addr = ''; // 주소 변수
		
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
		
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById("placePostcode").value = addr;
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("placePostcode").focus();
		        }
		    }).open();
		}
</script>

<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강의장 등록 정보</h1>
	</div>
	<div>
		<label>회원 idx</label>
		<input type="text" name="memberIdx">
	</div>
	<div>
		<label>장소 idx</label>
		<input type="text" name="placeIdx">
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
		 	<button type="button" id="kakao_Address" class="adCheck" onclick="kakaoAddress()" value="주소찾기">주소 찾기</button>
		 <label>강의장 상세주소</label>
			<input type="text" id="addressDetail" name="addressDetail" placeholder="상세 주소" required readonly>
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
			<input type="hidden" name="memberEmail" class="mail_input" >
		</div>
	</div>
	
	<div class="row">
		<label class="phone_name">핸드폰 번호</label>
		<div class="phone_wrap">
	 			<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone"> -
				<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone"> -
				<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone">	
				<input type="hidden" name="memberPhone" id="phoneNum">
		</div>
	</div>
	
	<div class="place_wrap">
		<label class="place_file_name">장소 파일</label>
		<input type="file" name="attach" accept="image/*" class="place_file_input">
	</div>

	<div class="row">
		<input type="submit" value="등록" class="form-btn">
	</div>
</div>

</div>	
</form>