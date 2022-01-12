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

$(function () {
	
	var password = RegExp(/^[A-Za-z0-9!@#$\s_-]{8,16}$/);
	
	/* 비밀번호 유효성 검사 */
	$("#pw").keyup(function () {
		if (!password.test($("#pw").val())) {
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
	$("#pwch").keyup(function () {
		if ($("#pwch").val() != $("#pw").val()) {
			$("#pwComm2").text("");
			$("#pwComm2").css("color", "red");
			$("#pwComm2").html("비밀번호가 동일하지 않습니다.");

			pwchCkeck = false;
			$("#btnclick").prop("disabled", true);
			$("#btnclick").css("color", "gray");
		} else {
			$("#pwComm2").html("");
			$(this).prop("disabled", false);

			pwchCkeck = true;
			$("#btnclick").prop("disabled", false);
		}
	});
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
			비밀번호 변경
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
						<label for="pw" class="form-label mb-0 form-input">현재 비밀번호</label>
						<input name="memberPw" type="password" class="form-control" placeholder="" value="">
                    </div>
                      <c:if test="${param.error != null}">
                          <div class="row center">
                          <h4 class="form-text fs-6">입력하신 정보가 일치하지 않습니다</h4>
                          </div>
                      </c:if>
					<div class="form-group mb-4 col-12">
						<label for="pw" class="form-label mb-0">변경 비밀번호</label>
						<input id="pw" name="changePw" type="password" class="form-control"  id="pw" placeholder="특수문자, 영문, 숫자, 6자 이상 20자 이내로 입력하세요" value="">
						<font id="pwComm" class="form-text fs-6"></font>
					</div>
					<div id="pwComm"></div>
					<div class="form-group mb-4 col-12">
						<label for="pw" class="form-label mb-0">비밀번호 확인</label>
						<input id="pw" name="changePw2" type="password" class="form-control" id="pwch" placeholder="비밀번호를 한번 더 입력하세요" value="">
						<font id="pwComm2" class="form-text fs-6"></font>
					</div>
					<div id="pwComm2"></div>					
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8">변경</button>
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

