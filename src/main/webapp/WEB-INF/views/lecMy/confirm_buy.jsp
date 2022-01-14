<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 강좌 구매 확인</TITLE>
<style type="text/css">

	/* card 클래스 설정으로 인한 flex 속성부여를 해제 */
	.rowTable {
		flex-direction: initial;
		border-right-width: 4px;
	}
	/* 커스텀 테이블 셀 설정 */
	.rowTableCell { min-height:3rem; }
	.rowTableBgTitle { background-color:#fde4cc; font-weight:700; }
	
	/* 커스텀 테이블 내부 테두리 설정 */
	.rowTableDiv  { --inner-border-color: rgba(0, 0, 0, 0.125); }
	.rowTableCell {
		border-right-width: 1px;
		border-right-style: solid;
		border-right-color: var(--inner-border-color);
	}
	.rowTableCell {
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: var(--inner-border-color);
	}
	/* xxl급 화면 이상에서 하단 테두리 제거 설정 */
	@media (min-width:1400px) {
		.rowTableCell:last-child { border-bottom:none; }
	}
	/* xl급 화면 이하에서 하단 테두리 제거 설정 */
	@media (max-width:1399px) {
		.rowTableDiv:last-child .rowTableCell:last-child { border-bottom:none; }
	}

}
	
</style>
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
			강좌 구매 내용 확인
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6 container">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>구매할 강좌</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<!-- 테이블 시작 -->
				<div class="row card border-3 p-0 d-flex align-items-center justify-content-center rowTable">
					<!-- TR 시작 -->
					<div class="col-md-12 col-xxl-6 m-0 p-0 rowTableDiv">
						<div class="container m-0 p-0">
							<div class="row m-0 p-0">
								<div class="col-6 m-0 p-0">
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">카테고리</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">강사명</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">기간</div>
								</div>
								<div class="col-6 m-0 p-0">
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell">${lecDetailVO.lecCategoryName}</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell">${lecDetailVO.memberNick}</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell">${lecDetailVO.lecStart} ~ ${lecDetailVO.lecEnd}</div>
								</div>
							</div>
						</div>
					</div>
					<!-- TR 끝 -->
					<!-- TR 시작 -->
					<div class="col-md-12 col-xxl-6 m-0 p-0 rowTableDiv">
						<div class="container m-0 p-0">
							<div class="row m-0 p-0">
								<div class="col-6 m-0 p-0">
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">지역</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">수강인원</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableBgTitle rowTableCell">수강료</div>
								</div>
								<div class="col-6 m-0 p-0">
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell">${lecDetailVO.placeName}</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell">${lecDetailVO.lecHeadCount} 명</div>
									<div class="text-center align-middle d-flex align-items-center justify-content-center rowTableCell"><fmt:formatNumber value="${lecDetailVO.lecPrice}" pattern="#,###" /> 포인트</div>
								</div>
							</div>
						</div>
					</div>
					<!-- TR 끝 -->
				</div>
				<!-- 테이블 끝 -->
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>포인트 소모 내역</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<div class="form-group my-5 col-12">
					<h3 class="text-info">현재 보유 포인트</h3>
					<h5>${currentPoint}</h5>
				</div>
				<div class="form-group my-5 col-12">
					<h3 class="text-info">포인트 소모량</h3>
					<h5><fmt:formatNumber value="${lecDetailVO.lecPrice}" pattern="#,###" /> 포인트</h5>
				</div>
				<div class="form-group my-5 col-12">
					<h3 class="text-info">이후 잔여 포인트</h3>
					<h5><fmt:formatNumber value="${currentPoint - lecDetailVO.lecPrice}" pattern="#,###" /> 포인트</h5>
				</div>
				<div class="row">
					<form class="pt-5 d-flex align-items-center justify-content-center" method="get" action="${root}/lecMy/buy"><button class="btn btn-sm btn-primary fs-4 p-2 px-4">강좌 구매하기</button></form>
				</div>
				<div class="row">
					<form class="pt-5 d-flex align-items-center justify-content-center" method="get" action="${root}/lec/detail/${lecDetailVO.lecIdx}"><button class="btn btn-sm btn-secondary fs-4 p-2 px-4">이전 화면으로 돌아가기</button></form>
				</div>
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
