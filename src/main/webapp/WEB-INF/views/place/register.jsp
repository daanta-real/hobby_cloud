<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강의장 등록 정보</h1>
	</div>장소 이름, 장소 소개, 장소 작성일, 장소 지역, 장소, 장소 대여가능 시작시간, 장소 대여 가능 종료시간,.
	장소 대여 금액 최소, 장소 대여금액 최대, 장소 이메일, 장소 전화번호 
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
			<option value="" class="pickRoom">용도 선택</option>
			<option value="directly">직접입력</option>
			<option value="music">음악</option>
			<option value="painting">미술</option>
			<option value="sports">운동</option>
		</select>
	</div>
	<div class="row">
	<div class="region_wrap">
		<label>강의장 주소</label>
		 	<input type="text" name="placePostcode" placeholder="우편번호" readonly id="placePostcode">
		 	<button type="button" id="kakao_Address" class="adCheck" onclick="kakaoAddress()" value="주소찾기">주소 찾기</button>
		 <label>강의장 상세주소</label>	
			<input type="text" id="addressDetail" name="addressDetail" placeholder="상세 주소" required readonly>
	</div>


	<div class="row">
		<label>대여가능기간</label>
		<input type="number" name="rentperiod">
	</div>
	<div class="row">
		<label>대여희망금액</label>
		<input type="number" name="rentfee">
	</div>
	<div class="row">
		<label>장소 사진</label>
		<input type="file" name="attach" accept="image/*" class="form-input">
	</div>
	<div class="row">
		<input type="submit" value="가입" class="form-btn">
	</div>
</div>
	
</form>