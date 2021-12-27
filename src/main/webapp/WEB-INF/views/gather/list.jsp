<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form  method="post">
 장소검색:	<input type="text" name="gatherLocRegion">
	
 제목 검색:	<input type="text" name="gatherName"> 
 <input type="submit" value="검색하기">
</form>
<c:forEach var="gatherDto" items="${list}"> 
1
<h1>번호 :${gatherDto.gatherIdx}
회원 : ${gatherDto.memberIdx}
장소 : ${gatherDto.placeIdx}
</h1>
</c:forEach>
<tr>