<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>강좌 검색</h1>

<h2>테마추천</h2>

<h2>상세검색</h2>

<h2>강좌목록</h2>
<c:forEach var="" items=""></c:forEach>

<div class="container-900 container-center">
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
					<th>과목</th>
					<th>대상</th>
					<th>강좌 구성</th>
					<th>수강 기간</th>
					<th>수강료</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="lecDto" items="${lecList}">
				<tr>
					<td>${lecDto.lecIdx}</td>
					<td>${lecDto.lecName}</td>
					<td>${lecDto.lecCategoryName}</td>
					<td>${lecDto.tutoridx}</td>
					<td>${historyDto.historyMemo}</td>
					<td>${historyDto.cancel}</td>
					<td></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>