<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 포인트상품 조회</TITLE>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
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
<jsp:include page="/resources/template/leftMenu.jsp" flush="false" />
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			포인트상품 등록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form name="pointForm" method="post" class="row container d-flex justify-content-center">
					<div class="form-group row mb-4">
						<label for="form_pointName" class="form-label mb-0">포인트상품명</label>
						<input name="pointName" id="form_pointName" type="text" class="form-input p-2 px-3 border-radius-all-25" placeholder="포인트상품 이름을 입력하세요" required>
					</div>
					<div class="row mb-4">
						<label>포인트상품 가격</label>
						<div class="input-group flex-nowrap grayInputGroup p-0">
							<div class="input-group-text">&#8361;</div>
							<input type="number" name="pointPrice" placeholder="가격을 입력하세요" required class="form-control">
						</div>
					</div>
					<div class="row mb-4">
						<label>포인트상품 충전량</label>
						<div class="input-group flex-nowrap grayInputGroup p-0">
							<input type="number" name="pointAmount" placeholder="충전량을 입력하세요" required class="form-control">
							<div class="input-group-text">포인트</div>
						</div>
					</div>
					<div class="row p-sm-2 mx-1 mb-5">
						<nav class="row p-0 pt-4 d-flex justify-content-between">
							<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="history.go(-1);">취소</button>
							<button type="submit" class="col-auto btn btn-sm btn-outline-primary">등록</button>
						</nav>
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
