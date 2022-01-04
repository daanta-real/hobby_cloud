<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />



<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container"><DIV class="row pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->
<ASIDE id="accordionSideMenu" class="accordion col-lg-3">
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading1">
			<button class="accordion-button" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse1"
				aria-expanded="true" aria-controls="collapse1">회원 관리</button>
		</h2>
		<div id="collapse1" class="accordion-collapse collapse show"
			aria-labelledby="heading1" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">회원 통계</div>
			<div class="accordion-body">회원 관리</div>
			<div class="accordion-body">1:1 채팅 이력 관리</div>
			<div class="accordion-body">채널 채팅 이력 관리</div>
			<div class="accordion-body">회원 등급 관리</div>
		</div>
	</div> 
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading2">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse2"
				aria-expanded="false" aria-controls="collapse2">
				강좌</button>
		</h2>
		<div id="collapse2" class="accordion-collapse collapse"
			aria-labelledby="heading2" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">강좌 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading3">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse3"
				aria-expanded="false" aria-controls="collapse3">
				장소</button>
		</h2>
		<div id="collapse3" class="accordion-collapse collapse"
			aria-labelledby="heading3" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">장소 관리</div>
			<div class="accordion-body">장소담당자 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading4">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse4"
				aria-expanded="false" aria-controls="collapse4">
				소모임</button>
		</h2>
		<div id="collapse4" class="accordion-collapse collapse"
			aria-labelledby="heading4" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">소모임 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading5">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse5"
				aria-expanded="false" aria-controls="collapse5">
				청원</button>
		</h2>
		<div id="collapse5" class="accordion-collapse collapse"
			aria-labelledby="heading5" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">청원 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading6">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse6"
				aria-expanded="false" aria-controls="collapse6">
				공지</button>
		</h2>
		<div id="collapse6" class="accordion-collapse collapse"
			aria-labelledby="heading6" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">공지 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading7">
			<button class="accordion-button collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse7"
				aria-expanded="false" aria-controls="collapse7">
				수익</button>
		</h2>
		<div id="collapse7" class="accordion-collapse collapse"
			aria-labelledby="heading7" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body">광고 관리</div>
			<a class="accordion-body" href="${root}/admin/pay/list">결제이력 관리</a>
		</div>
	</div>
</ASIDE>
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="col-md-12 col-lg-9 mt-md-3 d-flex align-items-start">

	<!-- 제목 영역 시작 -->
	<HEADER class='container-fluid mx-1 mb-1'>
	<div class='row border-bottom border-secondary border-1'>
	<span class="subject border-bottom border-primary border-5 fs-1 px-3">
	마이페이지
	</span>
	</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	
	<!-- 페이지 내용 시작 -->
	<SECTION class='p-3'>
	
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
