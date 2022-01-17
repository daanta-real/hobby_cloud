<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="login" value="${memberIdx != null }"></c:set>
<c:set var="Landlord" value="${memberGrade=='임대인'}"></c:set>
<!DOCTYPE HTML>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

</script>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
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
			강의장
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>목록</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">장소이름</th>
								<th scope="col" class="text-center align-middle text-nowrap">장소제공자</th>
								<th scope="col" class="text-center align-middle text-nowrap">주소</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="PlaceListVO" items="${list}">
								<tr class="cursor-pointer">
									<td class="text-center align-middle text-nowrap">${PlaceListVO.placeIdx}</td>
									<td class="text-center align-middle text-nowrap"><a href="${pageContext.request.contextPath}/place/detail/${PlaceListVO.placeIdx}">${PlaceListVO.placeName}</a></td>
									<td class="text-center align-middle text-nowrap">${PlaceListVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">${PlaceListVO.placeAddress}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
			<button type="button"class="col-auto btn btn-sm btn-outline-primary">목록으로</button>
			  <ul class="col-auto pagination pagination-sm m-0">
			    <c:if test="${pageMaker.prev}">
			    	<li class="page-item disabled"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"
			    	> ◁ </a></li>
			    </c:if> 
			
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    	<li class="page-item ${param.page == idx ? 'active' : ''}"><a  class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			    </c:forEach>
			
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">&raquo;</a></li>
			    </c:if> 
			  </ul>
			  <c:if test="${Landlord}"> 
			  <a class="col-auto btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/place/register">등록하기</a>
			  </c:if>	
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

