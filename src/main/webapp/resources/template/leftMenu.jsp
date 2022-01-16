<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="isAdmin" value="${sessionScope.memberGrade == '관리자'}" />
<c:set var="isLocManager" value="${sessionScope.memberGrade == '장소관리자' || sessionScope.memberGrade == '관리자'}" />

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD></HEAD>
<BODY>


<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->
<ASIDE id="accordionSideMenu" class="accordion col-lg-2">
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading1">
			<button class="accordion-button" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse1"
				aria-expanded="true" aria-controls="collapse1">회원 관리</button>
		</h2>
		<div id="collapse1" class="accordion-collapse collapse show"
				aria-labelledby="heading1" data-bs-parent="#accordionSideMenu"
				style="">
			<c:if test="${isAdmin}"><div class="accordion-body p-0"><a class="w-100 px-3 py-3 d-flex justify-content-start" href="${root}/my/member/">회원 관리</a></div></c:if>
			<div class="accordion-body p-0"><a class="w-100 px-3 py-3 d-flex justify-content-start" href="${root}/member/mypage">내 정보</a></div>
		</div>
	</div> 
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading2">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse2"
				aria-expanded="false" aria-controls="collapse2">
				강좌</button>
		</h2>
		<div id="collapse2" class="accordion-collapse collapse"
			aria-labelledby="heading2" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">강좌 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading3">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse3"
				aria-expanded="false" aria-controls="collapse3">
				장소</button>
		</h2>
		<div id="collapse3" class="accordion-collapse collapse"
			aria-labelledby="heading3" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">장소 관리</div>
			<div class="accordion-body px-3 py-2">장소담당자 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading4">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse4"
				aria-expanded="false" aria-controls="collapse4">
				소모임</button>
		</h2>
		<div id="collapse4" class="accordion-collapse collapse"
			aria-labelledby="heading4" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">소모임 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading5">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse5"
				aria-expanded="false" aria-controls="collapse5">
				청원</button>
		</h2>
		<div id="collapse5" class="accordion-collapse collapse"
			aria-labelledby="heading5" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">청원 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading6">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse6"
				aria-expanded="false" aria-controls="collapse6">
				공지</button>
		</h2>
		<div id="collapse6" class="accordion-collapse collapse"
			aria-labelledby="heading6" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">공지 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading7">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse7"
				aria-expanded="false" aria-controls="collapse7">
				수익</button>
		</h2>
		<div id="collapse7" class="accordion-collapse collapse"
			aria-labelledby="heading7" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">광고 관리</div>
			<a class="accordion-body px-3 py-2" href="${root}/admin/pay/list">결제이력 관리</a>
		</div>
	</div>
</ASIDE>
<!-- 사이드메뉴 영역 끝 -->


</BODY>
</HTML>

</HTML>
