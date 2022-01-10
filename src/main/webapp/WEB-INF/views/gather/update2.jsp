<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>

 
<h2>${GatherVO.gatherIdx}번 게시글 </h2>

<form method="post" enctype="multipart/form-data">
<!-- action="${pageContext.request.contextPath}/gather/update" -->

	
	취미분류<input type="text" name="lecCategoryName" value="${GatherVO.lecCategoryName}">
	<br>
	장소 <input id="placeIdxHolder" type="hidden" name="placeIdx"	value="9999"> 
	제목<input type="text" name="gatherName"		value="${GatherVO.gatherName}">
	상세내용<input type="text" name="gatherDetail"	value="${GatherVO.gatherDetail}"> <br> 		
	작성일<input type="date"	name="gatherRegistered" value="${GatherVO.gatherRegistered }"> 
	인원<input type="text"	name="gatherHeadCount" value="${GatherVO.gatherHeadCount}"> 
	지역<input type="text"	name="gatherLocRegion" value="${GatherVO.gatherLocRegion}"> 
	<br> 
	위도<input id="placeLatiHolder" type="text" name="gatherLocLatitude" value="${GatherVO.gatherLocLatitude}">
	경도<input id="placeLongHolder" type="text" name="gatherLocLogitude"	value="${GatherVO.gatherLocLongitude}">
	 시작시간<input type="date" name="gatherStart" value="${GatherVO.gatherStart}">
	<br> 
	종료시간<input type="date" name="gatherEnd" value="${GatherVO.gatherEnd}">
 	최대원인원수<input type="text" name="gatherMax" value="${GatherVO.gatherMax}"> 
	현재오픈여부<input type="text" name="gatherStaus" value="1"> <br>
			 <input type="file" name="attach" enctype="multipart/form-data" multiple>
	
	<input type="submit" value="전송하기">
	 <br> 
</form>
<c:forEach var="GatherFileDto" items="${list}"> 
	<span><${GatherFileDto.gatherFileUserName}</span>
	<br>
	<img src="${pageContext.request.contextPath}/gather/file/${GatherFileDto.gatherFileIdx}" width="30%" class="image image-round image-border">
	<button class="remove-btn" data-gatherfileidx="${GatherFileDto.gatherFileIdx}">삭제</button>
	</c:forEach>
			
				

		 
		





