<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="isAdmin" value="${sessionScope.memberGrade == '관리자'}" />
<c:set var="isLocManager" value="${sessionScope.memberGrade == '장소관리자' || sessionScope.memberGrade == '관리자'}" />

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지 - 회원목록</TITLE>
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
			${title}
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>검색 결과</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<c:forEach items="${list.get(0)}" var="one">
									<c:if test="${one.key != 'targetIdx'}">
										<th scope="col" class="text-center align-middle text-nowrap">${one.key}</th>
									</c:if>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="oneMap">
								<tr class="cursor-pointer" onclick="location.href='${root}/my/${menu}/detail/${oneMap.get('targetIdx')}';">
									<c:forEach items="${oneMap}" var="one">
										<c:if test="${one.key != 'targetIdx'}">
											<td class="text-center align-middle text-nowrap">${one.value}</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
				<a class="col-auto btn btn-sm btn-outline-primary bg-primary text-light" href="${root}/my/member">전체목록</a>
				<ul class="col-auto pagination pagination-sm m-0">
					<c:if test="${pageMaker.startPage < pageMaker.endPage}">
						<c:if test="${pageMaker.prev}">
							<li class="page-item disabled"><a class="page-link" href="${root}/my/member/${pageMaker.makeQuery(pageMaker.startPage - 1)}" >«</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item ${param.page == idx ? 'active' : ''}"><a  class="page-link" href="${root}/my/member/${pageMaker.makeQuery(idx)}">${idx}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item"><a class="page-link" href="${root}/my/member/${pageMaker.makeQuery(pageMaker.endPage + 1)}">»</a></li>
						</c:if>
					</c:if>
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

</HTML>
