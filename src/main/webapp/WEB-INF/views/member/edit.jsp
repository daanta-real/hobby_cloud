<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
<style type="text/css">
.squareImgContainer { padding-top: 50%; border: 1px solid lime; }
.squareImgContainer img { transform:translate(-50%, -50%); object-fit:contain; }
</style>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
	
	// 파일 input 태그에 새 파일이 첨부되었을 때 이미지 모습을 보여준다.
	document.getElementById("profileImageInput").addEventListener("change", function(e) {
		// 접수된 파일(들) 전송 정보 객체를 이벤트 객체에서 캐냄
		renderImageFromFile(e.target.files[0], document.getElementById("profileImageOutput"));
	})
	
	// 비밀번호 유효성 검사
	$("#pw").keyup(function(){
		if(!RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/).test($("#pw").val())){
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
	})

	// 주소 검색창 기능
	// findRegion을 누르면 자동으로 주소검색창이 나옴    
	// → input[name=memberRegion] 에 기본주소 작성한다.
	$(".findRegion").click(function(){
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
	});

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
	
});

</script>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />



<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			회원 정보 수정
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form method="post" enctype="multipart/form-data" id="join_form" class="row">
					<div class="form-group mb-4 col-12">
						<label class="id_name form-label mb-0">아이디</label>
						<input type="text" class="form-control" value="${memberDto.memberId}" readonly>
					</div>
					<div class="form-group mb-4 col-12">
						<label for="pw" class="form-label mb-0">비밀번호</label>
						<input id="pw" name="memberPw" type="password" class="form-control" placeholder="회원 번호를 입력하세요" value="${param.memberIdx}">
						<font id="pwComm" class="form-text fs-6"><c:if test="${param.error != null}">비밀번호가 일치하지 않습니다</c:if></font>
					</div>
					<div class="form-group mb-4 col-12">
						<label class="id_name form-label mb-0">닉네임</label>
						<input type="text" class="form-control" value="${memberDto.memberNick}" readonly>
					</div>
					<div class="form-group mb-4 col-12">
						<label class="form-label mb-0">이메일</label>
						<div>
							<span>${memberDto.memberEmail}</span>
							<input type="button" id="emailCheck" class="adCheck" value="메일변경하기" onclick="location.href='updateMail.jsp'">
						</div>
					</div>
					<div class="form-group mb-4 col-12 container">
						<label class="row form-label mb-0">핸드폰 번호</label>
						<div class="row d-flex">
							<div class="col-3"><input name="phone1" type="text" class="form-control col-4" maxlength="3" placeholder="000"/></div>
							<div class="col-4"><input name="phone2" type="text" class="form-control col-4" maxlength="4" placeholder="0000" /></div>
							<div class="col-4"><input name="phone3" type="text" class="form-control col-4" maxlength="4" placeholder="0000" /></div>
							<input type="hidden" id="phoneNum" name="phone">
						</div>
						<div id="phComm" class="row fs-6"></div>
					</div>
					<div class="form-group mb-4 col-12">
						<label for="region" class="form-label mb-0">주소</label>
						<input id="region" name="memberRegion" type="text" class="form-control" value="${memberDto.memberRegion}" readonly>
						<button type="button" class="">주소 찾기</button>
						<div id="regioncheck" class="fs-6"></div>
					</div>
					<div class="form-group mb-4 col-12">
						<label class="form-label mb-0">프로필 이미지</label>
						<input id="profileImageInput" name="attach" type="file" class="form-control" accept="image/*" >
						<div class="squareImgContainer position-relative d-flex justify-content-center align-items-center overflow-hidden w-50">
							<c:choose>
								<c:when test="${memberProfileDto == null}">
									<img id="profileImageOutput" class="position-absolute top-50 start-50 bottom-0 end-0 w-100" src="https://via.placeholder.com/300x300?text=사진을%20첨부하세요.">
								</c:when>
								<c:otherwise>
									<img id="profileImageOutput" class="position-absolute top-50 start-50 bottom-0 end-0 w-100"" src="profile?memberIdx=${memberProfileDto.memberIdx}" width="100%">
									<a href="profileDelete?memberIdx=${memberProfileDto.memberIdx}">삭제</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="form-group mb-4 col-lg-6">
						<label class="form-label mb-0">관심 분야</label>
						<div>
							<input type="checkbox" name="lecCategoryName"  value="sports">스포츠
							<input type="checkbox" name="lecCategoryName"  value="music">음악
							<input type="checkbox" name="lecCategoryName"  value="painting">그림
						</div>
					</div>
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8">수정하기</button>
					</div>
				</form>
			</div>
		</div>
	</SECTION>
<!-- 페이지 내용 끝. -->
	
</ARTICLE>
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>
