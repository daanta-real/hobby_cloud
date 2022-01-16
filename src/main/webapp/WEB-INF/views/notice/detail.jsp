<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<c:set var="login" value="${memberIdx != null }"></c:set>
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
			공지사항
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>${NoticeVO.noticeName }</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5 container">
			<!-- 글내용 -->
			<div class="row justify-content-end">
				등록일 : ${NoticeVO.noticeRegistered}
				|
				작성자 : ${NoticeVO.memberNick}
				|
				조회수 : ${NoticeVO.noticeViews}
			</div>
			<div class="row">
			${NoticeVO.noticeDetail }
			<c:forEach var="NoticeFileDto" items="${list}"> 
<img src="${pageContext.request.contextPath}/notice/file/${NoticeFileDto.noticeFileIdx}" width="30%" 
class="image image-round image-border">
</c:forEach>
			</div>
			<!-- 각종 버튼들 -->
			<nav class="row p-0 pt-4 d-flex justify-content-end">
				<a href="${pageContext.request.contextPath}/notice/list"
				 class="col-auto btn btn-sm btn-outline-primary mx-1">목록 보기</a>
				<c:if test="${admin }">
				<a href="${root }/notice/write" class="col-auto btn btn-sm btn-outline-primary mx-1">글 작성</a>
				<a href="${pageContext.request.contextPath}/notice/edit?noticeIdx=${NoticeVO.noticeIdx }"
				 class="col-auto btn btn-sm btn-secondary mx-1">수정</a>
				<a href="${pageContext.request.contextPath}/notice/delete?noticeIdx=${NoticeVO.noticeIdx }" 
				class="col-auto btn btn-sm btn-danger mx-1">삭제</a>
				</c:if>
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
