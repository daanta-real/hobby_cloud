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
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			포인트상품 목록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>검색 조건</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form name="searchForm" method="get" class="row">
					<div class="form-group mb-4 col-12">
						<label for="searchForm_pointIdx" class="form-label mb-0">포인트상품 번호</label>
						<input name="pointIdx" id="searchForm_pointIdx" type="number" class="form-control" placeholder="포인트 번호를 입력하세요" value="${param.pointIdx}">
					</div>
					<div class="form-group mb-4 col-12">
						<label for="searchForm_pointName" class="form-label mb-0">포인트상품명</label>
						<input name="pointName" id="searchForm_pointName" type="text" class="form-control" placeholder="포인트상품명을 입력하세요" value="${param.pointName}">
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">포인트상품 가격</span>
						</div>
						<div class="row d-flex flex-start justify-content-center">
							<div class="col-5">
								<input name="pointPriceMin" id="searchForm_pointPriceMin" type="number" class="form-control" placeholder="최소 금액" value="${param.pointPriceMin}" min=1000 max=1000000>
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="pointPriceMax" id="searchForm_pointPriceMax" type="number" class="form-control" placeholder="최대 금액" value="${param.pointPriceMax}" min=1000 max=1000000>
							</div>
						</div>
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">포인트상품 충전량</span>
						</div>
						<div class="row d-flex flex-start justify-content-center">
							<div class="col-5">
								<input name="pointAmountMin" id="searchForm_pointAmountMin" type="number" class="form-control" placeholder="최소 충전량" value="${param.pointAmountMin}" min=1000 max=10000000>
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="pointAmountMax" id="searchForm_pointAmountMin" type="number" class="form-control" placeholder="최대 충전량" value="${param.pointAmountMax}" min=1000 max=10000000>
							</div>
						</div>
					</div>
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8">검색</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>검색 결과</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">상품 번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">상품명</th>
								<th scope="col" class="text-center align-middle text-nowrap">구매가</th>
								<th scope="col" class="text-center align-middle text-nowrap">포인트 충전량</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="PointDto" items="${list}">
								<tr class="cursor-pointer" onclick="location.href='${root}/point/detail/${PointDto.getPointIdx()}'">
									<td class="text-center align-middle text-nowrap">${PointDto.getPointIdx()}</td>
									<td class="text-center align-middle text-nowrap">${PointDto.getPointName()}</td>
									<td class="text-center align-middle text-nowrap">&#8361;&nbsp;<fmt:formatNumber value="${PointDto.getPointPrice()}" pattern="#,###" /></td>
									<td class="text-center align-middle text-nowrap"><fmt:formatNumber value="${PointDto.getPointAmount()}" pattern="#,###" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
				<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/point/';">전체 목록</a></button>
				<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/point/insert';">신규상품 추가</a></button>
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
