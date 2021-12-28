<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form  method="post">

<input type="checkbox" name="location" value="서울">
서울
<input type="checkbox" name="location" value="경기도">
경기도
<input type="checkbox" name="location" value="제주도">
제주도
<input type="checkbox" name="location" value="강원도">
강원도
<input type="checkbox" name="location" value="2">
인천
	
 제목 검색:	<input type="text" name="title"> 
 <input type="submit" value="검색하기">
</form>
<c:forEach var="GatherVO" items="${list}"> 
1
<h1>
<a href="detail?gatherIdx=${GatherVO.gatherIdx}">번호 :${GatherVO.gatherIdx}</a>
<img src="file?gatherFileIdx=${GatherVO.gatherFileIdx}" width="50%" class="image image-round image-border">
회원 : ${GatherVO.memberIdx}
장소 : ${GatherVO.gatherLocRegion}
작성자: ${GatherVO.memberNick}
</h1>
</c:forEach>
<tr>