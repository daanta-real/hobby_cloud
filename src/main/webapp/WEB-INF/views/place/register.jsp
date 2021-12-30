<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강의장 등록 정보</h1>
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
		<label>주소</label>
		 	<input type="text" name="memberRegion" placeholder="주소"  readonly>
		 	<button type="button" class="findRegion">주소 찾기</button>
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