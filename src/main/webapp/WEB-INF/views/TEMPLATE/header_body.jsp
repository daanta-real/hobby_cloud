<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ↓ HEADER_BODY -->
<%
// 환경설정
%>

<!-- 디버그용 -->
<DIV ID="debugContainer">
	<form onsubmit="return false;">
		<INPUT ID='debug_query' TYPE=text VALUE="BODY *"/>
		<BUTTON ONCLICK='debug_rainbowQueryRun();'>레이어 해체보기</BUTTON>
	</form>
</DIV>

<!-- 모바일 메뉴 콘테이너 -->
<DIV ID='mobileMenuLayer' CLASS='mobile'>
	
	<!-- 모바일 메뉴 - 햄버거 버튼 -->
	<!-- <INPUT ID='mobileMenuHamburgerInput' TYPE='hidden'> -->
	<DIV ID="hamburgerBox">
		<LABEL FOR='mobileMenuHamburgerInput'>
			<SPAN></SPAN>
			<SPAN></SPAN>
			<SPAN></SPAN>
		</LABEL>
	</DIV>
	
	<!-- 모바일 메뉴 박스 -->
	<DIV ID='mobileMenuContainer'>
	
		<!-- 로그인 영역 -->
		<DIV ID='mobileMenuLoginContainer' CLASS="flexCenter flexCol">
			
			<%if(isLogin) { /* 로그인이 되었을 경우 */ %>
				<DIV CLASS="userInfoTxt flexCenter flexCol">
					<DIV CLASS="flexCenter flexCol">
						<SPAN><%=usersNick%>(<%=usersId%>)님</SPAN>
						<SPAN class="gradeBadge <%=gradeStr%>"><%=usersGrade%></SPAN>
					</DIV>
					<DIV CLASS="myMenues flexRow flexCenter">
						<A CLASS='userButton' HREF='<%=root%>/users/detail.jsp'>내 정보</A>
						<%if(isAdmin) {%><A CLASS='userButton' HREF='<%=root%>/admin/main.jsp'>관리</A><%}%>
						<A CLASS='userButton' HREF='<%=root%>/users/logout.nogari'>로그아웃</A>
					</DIV>
				</DIV>
								
			<%} else { /* 로그인이 되지 않았을 경우 */ %>
				<FORM ID='loginInput' CLASS='flexCenter flexCol' NAME='login' METHOD='POST' ACTION='<%=root%>/users/login.nogari'>
					<INPUT TYPE='text' NAME='usersId' VALUE="<% %>" PLACEHOLDER="입력하세요"/>
					<INPUT TYPE='password' NAME='usersPw' VALUE="<% %>" PLACEHOLDER="입력하세요"/>
					<DIV CLASS="loginButtonBox flexCenter flexRow">
						<BUTTON CLASS='actionButtons loginoutButton' TYPE='submit'>로그인</BUTTON>
						<A CLASS='actionButtons joinButton' HREF='<%=root%>/users/register.jsp'>회원가입</A>
					</DIV>
				</FORM>
			<%}%>
		</DIV>
			
		<!-- 주 메뉴 영역 -->
		<DIV ID='mobileMenuLinkContainer' CLASS="flexCenter flexCol">
			<A CLASS='menuLink blocked' HREF="<%=root%>/item/list_first.jsp">관광지 정보</A>
			<A CLASS='menuLink blocked' HREF="<%=root%>/course/list.jsp">코스 정보</A>
			<A CLASS='menuLink blocked' HREF="<%=root%>/event/list.jsp">이벤트 정보</A>
		</DIV>
		
	</DIV>
	
</DIV>

<!-- 상단메뉴 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">Navbar</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarColor01" aria-controls="navbarColor01"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link active" href="#">Home
						<span class="visually-hidden">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Features</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">Pricing</a></li>
				<li class="nav-item"><a class="nav-link" href="#">About</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#"
					role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a> <a
							class="dropdown-item" href="#">Something else here</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Separated link</a>
					</div></li>
			</ul>
			<form class="d-flex">
				<input class="form-control me-sm-2" type="text" placeholder="Search">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</div>
</nav>
<!-- ↑ HEADER_BODY -->