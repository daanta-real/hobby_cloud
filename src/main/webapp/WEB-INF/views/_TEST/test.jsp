<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 게시물 수정 폼</TITLE>
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
			게시물 수정
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>게시물 수정: {}</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">결제번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">회원번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">ID</th>
								<th scope="col" class="text-center align-middle text-nowrap">닉네임</th>
								<th scope="col" class="text-center align-middle text-nowrap">TID</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제일시</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제액</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="PaidVO" items="${paidList}">
								<tr class="cursor-pointer">
									<td class="text-center align-middle text-nowrap">${PaidVO.paidIdx}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberIdx}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberId}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.paidTid}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.paidRegisteredStr}</td>
									<td class="text-end align-middle text-nowrap">&#8361;&nbsp;<fmt:formatNumber value="${PaidVO.paidPrice}" pattern="#,###" /></td>
									<td class="text-center align-middle text-nowrap text-${paidStatus ? 'success' : 'danger'}">
										<c:choose>
											<c:when test="${paidStatus}">
												결제 완료&nbsp;<a href="${root}/pay/cancel/${PaidVO.paidIdx}" class="btn btn-warning btn-sm">결제 취소</a>
											</c:when>
											<c:otherwise>
												결제 취소됨
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row pt-4">
				<ul class="pagination justify-content-center">
					<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">&laquo;</a></li>
					<li class="page-item active"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
				</ul>
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
