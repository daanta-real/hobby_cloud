<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
	.float-container > .float-item-left:nth-child(1) {
		width:25%;	
		padding:0.5rem;
	}
	.float-container > .float-item-left:nth-child(2) {
		width:75%;
		padding:0.5rem;
	}
	
	.link-btn {
		width:100%;
	}
</style>

<!-- 이 페이지를 2단으로 구현 -->
<div class="container-900 container-center">
	<div class="row">
		<h2>회원 상세 정보</h2>
	</div>
	<div class="row float-container">
	91310100024929
		<!-- 1단 -->
		<div class="float-item-left">
			<!-- 회원 프로필 이미지 -->
			<div class="row">
				<c:choose>
					<c:when test="${memberProfileDto == null}">
					<img src="https://via.placeholder.com/300x300?text=User" width="100%" class="image image-round image-border">
					</c:when>
					<c:otherwise>
					<img src="profile?memberProfileIdx=${memberProfileDto.memberProfileIdx}" width="100%" class="image image-round image-border">
					</c:otherwise>
				</c:choose>
			
			</div>
			
			<!-- 회원 아이디 -->
			<div class="row center">
				<h2>${memberDto.memberId}</h2>
			</div>
			
			<!-- 각종 메뉴들 -->
			<div class="row center">
				<a href="password" class="link-btn-block">비밀번호 변경</a>
			</div>
			<div class="row center">
				<a href="edit" class="link-btn-block">개인정보 변경</a>
			</div>
			<div class="row center">
				<a href="quit" class="link-btn-block">회원 탈퇴</a>
			</div>
			
		</div>
		
		<!-- 2단 -->
		<div class="float-item-left">
		
			<!-- 회원 정보 출력 -->
			<div class="row">
				<h2>회원 상세 정보</h2>
			</div>
			<div class="row">
				<table class="table table-stripe">
					<tbody>
						<tr>
							<th width="25%">아이디</th>
							<td>${memberDto.memberId}</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>${memberDto.memberNick}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${memberDto.memberEmail}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${memberDto.memberPhone}</td>
						</tr>
						<tr>
							<th>가입일시</th>
							<td>${memberDto.memberRegistered}</td>
						</tr>
						<tr>
							<th>포인트</th>
							<td>${memberDto.memberPoint}</td>
						</tr>
						<tr>
							<th>포인트</th>
							<td>${memberDto.memberRegion}</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>${memberDto.memberGradeName}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
</div>