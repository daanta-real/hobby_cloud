<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="login" value="${memberIdx != null }"></c:set>
 <c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<h1>청원 게시판</h1>
<br><br>
<table border="1" width="90%">
	<thead>
		<tr>
			<th>번호</th>
			<th width="45%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>댓글수</th>
		</tr>
	</thead>


	<tbody align="center">
		<c:forEach var="PetitionsVO" items="${list}">
			<tr>
				<td>${PetitionsVO.petitionsIdx}</td>
				<td align="left">
				<a href="detail/${PetitionsVO.petitionsIdx }">${PetitionsVO.petitionsName }</a>
				</td>
				<td>${PetitionsVO.memberNick }</td>
				<td>${PetitionsVO.petitionsRegistered }</td>
				<td>${PetitionsVO.petitionsViews }</td>
				<td>${PetitionsVO.petitionsReplies }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<br>


<h1>${memberIdx}</h1>
<h1>${memberGrade }</h1>


<c:if test="${admin }">
<a href="write">글쓰기</a>

</c:if>




<!-- 검색창 -->
<form method="post">
	
	<select name="column">
		<option value="notice_name" selected>제목</option>
		<option value="notice_detail">내용</option>
		<option value="member_nick">작성자</option>
	</select>
	
	<input type="search" name="keyword" placeholder="검색어 입력" required >
	
	<input type="submit" value="검색">
	
</form>
