<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form method="post">

<div class="container-400 container-center">
	<div class="row center">
		<h1>회원 로그인</h1>
	</div>
	<!-- 
		saveId라는 이름의 쿠키가 존재하면 "아이디를 저장한 상태"로 간주
			- 아이디 입력창에 아이디(쿠키에 저장된 값)를 표시
			- 아이디 저장하기 체크박스에 체크 표시	
	 -->
	<div class="row"> 
		<label>아이디</label>
		<input type="text" name="memberId" required class="form-input" 
		autocomplete="off" value="${cookie.saveId.value}">
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class="form-input">
	</div>
	
	<div class="row">
		<label>
			<c:choose>
				<c:when test="${cookie.saveId == null }">
					<input type="checkbox" name="saveId">				
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="saveId" checked>				
				</c:otherwise>
			</c:choose>
			아이디 저장
		</label>
	</div>
	
	<div class="row right">
		<input type="submit" value="로그인" class="form-btn form-inline">
	</div>
	
	<c:if test="${param.error != null}">
	<div class="row center"> 
		<h4 class="error">로그인 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
</div>

</form>
