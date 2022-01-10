<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
 <c:set var="login" value="${memberIdx != null }"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>

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
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			청원
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">사진</th>
								<th scope="col" class="text-center align-middle text-nowrap">제목</th>
								<th scope="col" class="text-center align-middle text-nowrap">작성자</th>
								<th scope="col" class="text-center align-middle text-nowrap">작성일</th>
								<th scope="col" class="text-center align-middle text-nowrap">조회수</th>
								<th scope="col" class="text-center align-middle text-nowrap">댓글수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="PetitionsVO" items="${list}">
								<tr class="cursor-pointer">
									<td class="text-center align-middle text-nowrap">${PetitionsVO.petitionsIdx}</td>
									<td class="text-center align-middle text-nowrap"></td>
									<td class="text-center align-middle text-nowrap"><a href="detail/${PetitionsVO.petitionsIdx }">${PetitionsVO.petitionsName }</a></td>
									<td class="text-center align-middle text-nowrap">${PetitionsVO.memberNick }</td>
									<td class="text-center align-middle text-nowrap">${PetitionsVO.petitionsRegistered }</td>
									<td class="text-center align-middle text-nowrap">${PetitionsVO.petitionsViews }</td>
									<td class="text-center align-middle text-nowrap">${PetitionsVO.petitionsReplies }</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
<!-- 검색창 -->
<form method="post" class="mt-5">
	
	<select name="column">
		<option value="petitions_name" selected>제목</option>
		<option value="petitions_detail">내용</option>
		<option value="member_nick">작성자</option>
	</select>
	
	<input type="search" name="keyword" placeholder="검색어 입력" required >
	
	<button type="submit" class="btn btn-danger btn-sm">검색</button>
	
</form>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
		<button type="button"
			class="col-auto btn btn-sm btn-outline-primary">목록으로</button>
		<ul class="col-auto pagination pagination-sm m-0">
			<li class="page-item disabled">
				<a class="page-link" href="#" tabindex="-1" aria-disabled="true">«</a>
			</li>
			<li class="page-item active">
				<a class="page-link" href="#">1</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="#">2</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="#">3</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="#">»</a>
			</li>
		</ul>
       
		<a class="col-auto btn btn-sm btn-outline-primary" href="write">글쓰기</a>
		
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
