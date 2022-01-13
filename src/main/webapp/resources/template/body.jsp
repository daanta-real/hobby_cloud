<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<%-- 모달 영역. HTML의 가장 처음에 배치해야 한다 --%>
<div id="modal" class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content p-3">
			<%-- 모달 제목 영역 --%>
			<div class="modal-header">
				<%-- 모달 타이틀 --%>
				<h5 class="modal-title"></h5>
				<%-- 모달 닫기 버튼 --%>
				<%-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. --%>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<%-- 모달 본문 영역 --%>
			<div class="modal-body table table-striped">
			</div>
			<%-- 모달 꼬리말 영역 --%>
			<div class="modal-footer">
				<%-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button> --%>
			</div>
		</div>
	</div>
</div>

<NAV class="navbar navbar-expand-md navbar-dark bg-primary">
	<div class="container-fluid">

		<%-- 사이트명, 항상 표시 --%>
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">HobbyCloud.</a>

		<%-- 햄버거, 모바일에서만 표시 --%>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarColor01" aria-controls="navbarColor01"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<%-- 메뉴바. PC에서는 항상 표시. 모바일에서는 기본 숨김 + 햄버거 클릭 시에만 표시 --%>
		<div class="collapse navbar-collapse" id="navbarColor01">

			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/lec/list">강좌</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gather/list">소모임</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/petitions/list">청원</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/notice/list">공지</a></li>
			</ul>

			<form class="d-flex mt-2 mt-md-0">
				<input class="form-control form-control-sm mt-xs-2 mt-md-0 mx-xs-0 mx-sm-1 my-0" type="text" placeholder="Search">
				<button class="btn btn-sm btn-secondary mt-xs-2 mt-md-0 mx-xs-0 mx-sm-1 my-0" type="submit">Search</button>
			</form>
			<c:choose>
				<%-- 로그인했을 경우 내 회원정보 표시 --%>
				<c:when test="${not empty sessionScope.memberId}">
					<div id="topProfileBox" class="d-flex flex-row align-items-center"
						onclick="location.href='${pageContext.request.contextPath}/member/mypage'">
						<img id="topProfileImage" class="rounded-circle mx-1 border border-light border-2"
							src="${pageContext.request.contextPath}/member/profile/${sessionScope.memberIdx}" />
						<div class="d-flex flex-column align-items-center mx-1">
							<span class="navLoginNick text-light">${sessionScope.memberNick}</span>
							<span class="navLoginId text-light">(${sessionScope.memberId})</span>
						</div>
						<a href="${pageContext.request.contextPath}/member/logout" class="mx-2 fs-4 text-light">
							<i class="xi-power-off"></i>
						</a>
					</div>
				</c:when>
				<%-- 로그인하지 않았을 경우 ID/PW 입력창 표시 --%>
				<c:otherwise>
					<form id="topLoginBox" class="d-flex mt-2 mt-md-0" action="${pageContext.request.contextPath}/member/login" method="post">
						<input class="form-control form-control-sm mt-xs-2 mt-md-0 mx-xs-0 mx-sm-1 my-0" type="text" size=5
							id="topLoginBoxMemberId" name="memberId" required class="form-input" placeholder="ID" />
						<input class="form-control form-control-sm mt-xs-2 mt-md-0 mx-xs-0 mx-sm-1 my-0" type="password" size=5
							id="topLoginBoxMemberPw" name="memberPw" required class="form-input" placeholder="Password" />
						<button class="btn btn-sm btn-secondary mt-xs-2 mt-md-0 mx-xs-0 mx-sm-1 my-0"
							id="topLoginBtn"><span id="topLoginBtnSpan">Login</span><div class="spinner mx-1"></div></button>
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</NAV>