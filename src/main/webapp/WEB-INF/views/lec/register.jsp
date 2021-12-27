<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=04960945d1766f88ab55dee4b1108961"></script>
<script>

$(function(){
	//직접입력 인풋박스 기존에는 숨어있다가
	$("#selboxDirect").hide();
		$("#selbox").change(function() {
        //직접입력을 누를 때 나타남
		if($("#selbox").val() == "direct") {
			$("#selboxDirect").show();
		} else {
			$("#selboxDirect").hide();
		}
	})
});
</script>

<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강좌 등록</h1>
	</div>
	<div class="row">
		<label>강좌 이름</label>
		<input type="text" name="lecName" required class="form-input">
	</div>
	<div class="row">
		<label>카테고리</label>
		<select name="lecCategoryName" required class="form-input">			
			<option value="">선택하세요</option>
			<option>운동</option>
			<option>요리</option>
			<option>문화</option>
			<option>예술</option>
			<option>IT</option>
			<option>기타</option>
		</select>
	</div>
	<div class="row">
		<label>대여할 장소</label>
		<select name="placeIdx" required class="form-input" id="selbox">
		<c:forEach var="placeDto" items="${placeList}">
			<option>${placeDto.placeName}</option>
		</c:forEach>
			<option value="direct">직접입력</option>
		</select>
		<!-- 상단의 select box에서 '직접입력'을 선택하면 나타날 인풋박스 -->
		<!-- api 이용해야되는데 아직 잘 모르겠음 -->
		<input type="text" id="selboxDirect" name="lecLocRegion"/>
	</div>
	<div class="row">
		<label class="form-block">강좌 시작 시간</label>
		<input type="date" name="lecStart" required class="form-input form-inline">
	</div>
	<div class="row">
		<label class="form-block">강좌 종료 시간</label>
		<input type="date" name="lecEnd" required class="form-input form-inline">
	</div>
	<div class="row">
		<label>수강료</label>
		<input type="number" name="lecPrice" required class="form-input">
	</div>
	<div class="row">
		<label>수강 인원</label>
		<input type="number" name="lecHeadCount" required class="form-input">
	</div>
	<div class="row">
		<label>강의 수</label>
		<input type="number" name="lecContainsCount" required class="form-input">
	</div>
	<div class="row">
		<label>프로필 사진</label>
		<input type="file" name="attach" accept="image/*" class="form-btn">
	</div>
	<div class="row">
		<input type="submit" value="등록" class="form-btn">
	</div>
</div>

</form>