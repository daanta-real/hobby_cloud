<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="paidStatus" value="${PaidVO.paidStatus != '1'.charAt(0)}" />
<!DOCTYPE HTML>
<HTML LANG="ko">



<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 결제 상세조회</TITLE>
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



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			결제 상세 조회 ${PaidVO.paidPrice}
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>${kakaoPayVO.item_name}</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<ul class="">
				<li>주문번호: No. ${paidVO.paidIdx} (카카오페이 ${paidVO.paidTid})</li>
				<li>주문 회원: No. ${paidVO.memberIdx} ${paidVO.memberNick} (ID ${paidVO.memberId})님</li>
				<li>결제 금액: &#8361; <fmt:formatNumber value="${paidPrice}" pattern="#,###"/></li>
				<li>결제 일시: ${paidVO.paidRegisteredStr}</li>
				<li>결제 상태:
					<span class="text-${paidStatus ? success : danger}">
						${paidStatus ? "결제 완료" : "취소됨" }
					</span>
				</li>
			</ul>
			<ul class="row">
				<li>상품명: ${kakaoPayVO.item_name}</li>
				<li>상품 코드: ${kakaoPayVO.item_code}</li>
				<li>상품 수량: ${kakaoPayVO.quantity}</li>
				<li>결제 시각: ${kakaoPayVO.created_at}</li>
				<li>승인 시각: ${kakaoPayVO.approved_at}</li>
				<li>결제 수단: ${kakaoPayVO.payment_method_type}</li>
				<li>취소 가능 금액: ${kakaoPayVO.cancel_available_amount.total}</li>
				<li>결제 카드 정보: ${kakaoPayVO.selected_card_info}</li>
				<c:if test="${paidStatus == false}">
					<li>취소 시각: ${kakaoPayVO.canceled_at}</li>
					<li>취소된 총 금액: &#8361;&nbsp;<fmt:formatNumber value="${kakaoPayVO.canceled_amount.total}" pattern="#,###"/></li>
					<li>결제 취소 상세정보
						<c:out value="${kakaoPayVO.payment_action_details}"/>
					</li>
				</c:if>
			</ul>
		</div>
		<nav class="row pt-4 d-flex flex-justify-between">
			<a href="list">목록으로</a>
		</nav>
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
		