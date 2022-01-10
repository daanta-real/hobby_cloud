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

deleteConfirm() {
	if(confirm('정말로 삭제하시겠습니까?')) location.href = "delete/${pointIdx}";
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
			포인트상품 조회
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="form-group mb-4 col-12">
			<h3>포인트상품 번호</h3>
			<h4>${dto.getPointIdx()}</h4>
		</div>
		<div class="form-group mb-4 col-12">
			<h3>포인트상품명</h3>
			<h4>${dto.getPointName()}</h4>
		</div>
		<div class="form-group mb-4 col-12">
			<h3>포인트상품 가격</h3>
			<h4>$&#8361;&nbsp;<fmt:formatNumber value="${dto.getPointPrice()}" pattern="#,###" /></h4>
		</div>
		<div class="form-group mb-4 col-12">
			<h3>포인트상품 포인트 충전량</h3>
			<h4><fmt:formatNumber value="${dto.getPointAmount()}" pattern="#,###" /></h4>
		</div>
		<div class="row p-sm-2 mx-1 mb-5">
			<nav class="row p-0 pt-4 d-flex justify-content-between">
				<a href="/" class="col-auto btn btn-sm btn-outline-primary">전체 목록</a>
				<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="deleteConfirm();">상품 삭제</button>
			</nav>
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
