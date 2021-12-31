<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form  method="post">

<!-- <input type="checkbox" name="location" value="서울"> -->
<!-- 서울 -->
<!-- <input type="checkbox" name="location" value="경기도"> -->
<!-- 경기도 -->
<!-- <input type="checkbox" name="location" value="제주도"> -->
<!-- 제주도 -->
<!-- <input type="checkbox" name="location" value="강원도"> -->
<!-- 강원도 -->
<!-- <input type="checkbox" name="location" value="인천"> -->
<!-- 인천 -->
	
<!--  제목 검색:	<input type="text" name="title">  -->
 <input type="checkbox" name="category" value="운동">
 <input type="checkbox" name="category" value="미술">
 <input type="submit" value="검색하기">
 <a href="${pageContext.request.contextPath}/gather/insert">글쓰기</a>
</form>





<table border="1" width="90%">
	<thead>
		<tr>
		<th width="30%">사진></th>
			<th>번호</th>
			<th >제목</th>
			<th>작성자</th>
			<th>지역</th>
			<th>인원</th>
			<th>제목</th>
		</tr>
	</thead>


	<tbody align="center">
		<c:forEach var="GatherVO" items="${list}">
			<tr>
			
			<td>
			<img src="${pageContext.request.contextPath}/gather/file/${GatherVO.gatherFileIdx}" width="20%">
			</td>
			
				<td>${GatherVO.gatherIdx}</td>
				<td align="left">
				<a href="${pageContext.request.contextPath}/gather/detail/${GatherVO.gatherIdx }">${GatherVO.gatherName }</a>
				</td>
				<td>${GatherVO.memberNick }</td>
				<td>${GatherVO.gatherLocRegion }</td>
				<td>${GatherVO.gatherHeadCount }</td>
				<td>${GatherVO.gatherName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<tr>