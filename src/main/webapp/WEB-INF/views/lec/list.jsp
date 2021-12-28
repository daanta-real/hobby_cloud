<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form  method="post">
<div class="container-900 container-center">
	
 	장소 : <input type="text" name="lecLocRegion">
 	강좌 제목 :	<input type="text" name="lecName"> 
 	<input type="submit" value="검색하기">
 	
	<div class="row">
		<h2>강좌 검색</h2>
	</div>
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>No</th>
					<th>이름</th>
					<th>분류</th>
					<th>강사</th>
					<th>강좌 수강 인원</th>
					<th>강좌 지역</th>
					<th>수강료</th>
					<c:if test="${memberGrade == admin">
						<th>메뉴</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="lecDto" items="${list}">
				<tr>
					<td>${lecDto.lecIdx}</td>
					<td>${lecDto.lecName}</td>
					<td>${lecDto.lecCategoryName}</td>
					<td>${lecDto.tutorIdx}</td>
					<td>${lecDto.lecHeadCount}</td>
					<td>${lecDto.lecLocRegion}</td>
					<td>${lecDto.lecPrice}</td>
					<td>
					<c:if test="${memberGrade == admin">
						<a href="edit?lecNo=${lecDto.lecNo}">수정</a>
						<a href="delete?lecNo=${lecDto.lecNo}">삭제</a>
					</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</form>