<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 회원 정보 수정</TITLE>
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
	
	$("#btnclick").click(function(){
		let memberPhone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		$('input[name="memberPhone"]').val(memberPhone);
		console.log(
				"합해진 핸드폰 번호 memberPhone : " +
					$("#phone1").val() +
					$("#phone2").val() +
					$("#phone3").val()
			);
	})	
	
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
		         $("#btnclick").css("color", "white");
		         $("#btnclick").prop("disabled", false);
	         } 
	  });
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
		
	let email = '${memberDto.memberEmail}';
	$('input[name="email_id"]').val(email.substr(0,email.indexOf("@")));
	$('input[name="email_domain"]').val(email.substr(email.indexOf("@")+1,email.length));
	
	let phone = '${memberDto.memberPhone}';
	$('input[name="phone1"]').val(phone.substr(0,3));
	$('input[name="phone2"]').val(phone.substr(3,4));
	$('input[name="phone3"]').val(phone.substr(7,4));	
/* 	let lecCategoryName = '${memberCategoryDto.lecCategoryName}';
	$("select[name=lecCategoryName]").val(lecCategoryName);
	$("select[name=lecCategoryName]" option:selected).text(lecCategoryName); 
 */	
});


$(function(){
	$(".remove-btn").click(function(){
		var memberProfileIdxValue = $(this).data("member-profileidx");
		deleteFile(memberProfileIdxValue);
	});
});

function deleteFile(memberProfileIdxValue){
	
	$.ajax({
		url:"${pageContext.request.contextPath}/member/fileDelete?memberProfileIdx="+memberProfileIdxValue,
		type:"delete",
		dataType:"text",
		success:function(resp){
			
			console.log("성공",resp);
			
		},
		error:function(e){
			console.log("실패");
		}
	});
}

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
			<div class="container">
				<form method="post" enctype="multipart/form-data" id="join_form" class="row row container d-flex justify-content-center">
					<input type="hidden" name="memberPw" id="pw" class="mail_input" value="${memberDto.memberId}">
					<div class="form-group mb-4 col-12">
						<label class="id_name form-label mb-0">아이디</label>
						<input type="text" class="form-control" value="${memberDto.memberId}" readonly>
					</div>
					<div class="form-group mb-4 col-12">
						<label for="pw" class="form-label mb-0">비밀번호</label>
						<input id="pwch" name="memberPw2" type="password" class="form-control" placeholder="비밀번호를 입력하세요" >
						<div id="pwComm2"></div>
					</div>
					<div class="form-group mb-4 col-12">
						<label class="id_name form-label mb-0">닉네임</label>
						<input type="text" class="form-control" value="${memberDto.memberNick}" readonly>
					</div>
					<div class="form-group mb-4 col-12">
						<label class="form-label mb-0">이메일</label>
						<div>
							<span>${memberDto.memberEmail}</span>
							<input type="button" id="emailCheck" class="adCheck" value="메일변경하기" onclick="location.href='updateMail'">
						</div> 
					</div>
					<div class="form-group mb-4 col-12 container">
						<label class="row form-label mb-0">핸드폰 번호</label>
						<div class="row d-flex">
							<div class="col-3"><input name="phone1" id="phone1" type="text" class="form-control col-4" maxlength="3" placeholder="000"/></div>
							<div class="col-4"><input name="phone2" id ="phone2"type="text" class="form-control col-4" maxlength="4" placeholder="0000" /></div>
							<div class="col-4"><input name="phone3" id = "phone3"type="text" class="form-control col-4" maxlength="4" placeholder="0000" /></div>
							<input type="hidden" id="phoneNum" name="memberPhone">
						</div>
						<div id="phComm" class="row fs-6"></div>
					</div>
					<div class="form-group mb-4 col-12">
						<label for="region" class="form-label mb-0">주소</label>
						<input id="region" name="memberRegion" type="text" class="form-control" value="${memberDto.memberRegion}" readonly>
						<button type="button" class="findRegion">주소 찾기</button>
						<div id="regioncheck" class="fs-6"></div>
					</div>
					<div class="form-group mb-4 col-12">
						<label for="joinForm_lecCategory" class="form-label mb-0">관심분야</label>		
						<select name="lecCategoryName" required class="lecCategoryName form-input p-1 border-radius-all-25 form-control">
							<c:if test="${memberCategoryDto.lecCategoryName eq '운동'}">						
								<option value="운동" selected>운동</option>
								<option value="요리">요리</option>
								<option value="문화">문화</option>
								<option value="예술">예술</option>
								<option value="IT">IT</option>
							</c:if>
							<c:if test="${memberCategoryDto.lecCategoryName eq '운동'}">
								<option value="운동" selected>운동</option>
								<option value="요리">요리</option>
								<option value="문화">문화</option>
								<option value="예술">예술</option>
								<option value="IT">IT</option>
							</c:if>
							<c:if test="${memberCategoryDto.lecCategoryName eq '요리'}">
								<option value="운동">운동</option>
								<option value="요리" selected>요리</option>
								<option value="문화">문화</option>
								<option value="예술">예술</option>
								<option value="IT">IT</option>
							</c:if>
							<c:if test="${memberCategoryDto.lecCategoryName eq '문화'}">
								<option value="운동">운동</option>
								<option value="요리">요리</option>
								<option value="문화" selected>문화</option>
								<option value="예술">예술</option>
								<option value="IT">IT</option>
							</c:if>
							<c:if test="${memberCategoryDto.lecCategoryName eq '예술'}">
								<option value="운동">운동</option>
								<option value="요리">요리</option>
								<option value="문화">문화</option>
								<option value="예술"selected>예술</option>
								<option value="IT">IT</option>
							</c:if>
							<c:if test="${memberCategoryDto.lecCategoryName eq 'IT'}">
								<option value="운동">운동</option>
								<option value="요리">요리</option>
								<option value="문화">문화</option>
								<option value="예술">예술</option>
								<option value="IT" selected>IT</option>
							</c:if>
							<c:if test="">		
								<option value="" class="">선택하세요</option>
								<option value="운동">운동</option>
								<option value="요리">요리</option>
								<option value="문화">문화</option>
								<option value="예술">예술</option>
								<option value="IT">IT</option>
								<option value="directly">직접입력</option>							
							</c:if>
						</select>
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
									<img id="profileImageOutput" class="position-absolute top-50 start-50 bottom-0 end-0 w-100"" src="profile/${memberProfileDto.memberIdx}" width="100%">
									<button class="remove-btn" data-member-profileidx="${memberProfileDto.memberProfileIdx}">삭제</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" id="btnclick" class="btn btn-danger col-sm-12 col-md-9 col-xl-8 border-radius-all-25 form-control">수정하기</button>
					</div>
				</form>
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