<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
</HEAD>
<BODY>
<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->

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
			로그인
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<div class="row d-flex justify-content-center">
					<form method="post" class="col-lg-10 col-xl-8 col-xxl-6 container d-flex flex-column justify-content-center">
						<div class="form-group row mb-4">
							<label for="loginForm_memberId" class="form-label mb-0 id_input">아이디</label>
							<div class="row">
								<input name="memberId" id="loginForm_memberId" type="text" class="userId form-control form-input" autocomplete="off" value="${cookie.saveId.value}"required>
							</div>
						</div>
						<div class="row mb-4">
							<label for="loginForm_memberPw" class="form-label mb-0">비밀번호</label>
							<div class="row">
								<input name="memberPw" id="loginForm_memberId" type="password" class="pw form-control form-input" >
							</div>	
						</div>
						<div class="row mb-4">
							<label>
								<c:choose>
									<c:when test="${cookie.saveId == null}">
										<input type="checkbox" name="saveId" class="form-check-input">
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="saveId" checked class="form-check-input">
									</c:otherwise>
								</c:choose>
								아이디 저장
							</label>
						</div>
						<div class="form-row text-center">
							<input type="submit" value="로그인" class="btn btn-danger form-btn form-inline">
						</div>
						<nav class="row p-0 pt-4 d-flex justify-content-end">
							<a href="${root}/member/join" class="col-auto btn btn-sm btn-outline-primary mx-1">회원가입 하기</a>
						</nav>
						<nav class="row p-0 pt-4 d-flex justify-content-end">
							<a href="${root}/member/idfindMail" class="col-auto btn btn-sm btn-outline-primary mx-1">아이디 찾기</a>
							<a href="${root}/member/pwFindMail" class="col-auto btn btn-sm btn-outline-primary mx-1">비밀번호 찾기</a>
						</nav>
												
						<c:if test="${param.error != null}">
							<div class="row center"> 
								<h4 class="error">로그인 정보가 일치하지 않습니다</h4>
							</div>
						</c:if>
					</form>
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