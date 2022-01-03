<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강좌 수정</h1>
	</div>
	<div class="row">
		<label>강좌 이름</label>
		<input type="text" name="lecName" required class="form-input" value="${lecName}">
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
		<label>강좌 상세내용</label>
		<textarea rows="5" cols="20" name="lecDetail" required class="form-input"></textarea>
	</div>
	<div class="row">
		<label>대여할 장소</label>
		<!-- 1. 장소 리스트에 있는 곳을 고를 경우  -->
		<!-- 2. 직접 장소를 고를 경우(지도 api에서 클릭) -->
		<!-- 3. 온라인 or null -->
<!-- 		<select name="placeIdx" required class="form-input" id="selbox"> -->
<%-- 		<c:forEach var="placeDto" items="${placeList}"> --%>
<%-- 			<option>${placeDto.placeName}</option> --%>
<%-- 		</c:forEach> --%>
<!-- 			<option value="direct">직접입력</option> -->
<!-- 		</select> -->
		<!-- 상단의 select box에서 '직접입력'을 선택하면 나타날 인풋박스 -->
<!-- 		<input type="text" id="selboxDirect" name="lecLocRegion"/> -->
		<input type="number" name="placeIdx" required class="form-input">
		<div id="selboxDirect" style="width:500px;height:400px;"></div>
		
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
		<label class="form-block">강좌 시작 시간</label>
		<input type="date" name="lecStart" required class="form-input form-inline">
	</div>
	<div class="row">
		<label class="form-block">강좌 종료 시간</label>
		<input type="date" name="lecEnd" required class="form-input form-inline">
	</div>
<!-- 	<div class="row"> -->
<!-- 		<label>첨부 파일</label> -->
<!-- 		<input type="file" name="attach" class="form-btn"> -->
<!-- 	</div> -->
	<div class="row">
		<input type="submit" value="수정" class="form-btn">
	</div>
</div>

</form>