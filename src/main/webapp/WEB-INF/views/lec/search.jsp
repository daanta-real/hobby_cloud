<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="search" method="get">
 장소검색:	<input type="text" name="lecLocRegion" value="${lecLocRegion}">
	
 강좌 제목 검색:	<input type="text" name="lecName" value="${lecName}"> 
 <input type="submit" value="검색하기">
</form>
<c:forEach var="lecDto" items="${list}"> 
	<h1>번호 :${lecDto.lecIdx}
		카테고리 : ${lecDto.lecCategoryName}
		장소 : ${lecDto.placeIdx}
		수강 인원 : ${lecDto.lecHeadCount}
	</h1>
</c:forEach>
<tr>