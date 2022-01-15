<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="search" method="get">
아이디 검색:	<input type="text" name="memberId" value="${memberId}">
	
이름 검색:	<input type="text" name="memberNick" value="${memberNick}"> 

등급 검색:<input type="text" name="memberGradeName" value="${memberGradeName}"> 
 <input type="submit" value="검색하기">
</form>
<c:forEach var="gatherDto" items="${list}"> 
1
<h1>번호 :${memberDto.gatherIdx}
회원 : ${memberDto.memberIdx}
등급 : ${memberDto.placeIdx}
</h1>
</c:forEach>
<tr>