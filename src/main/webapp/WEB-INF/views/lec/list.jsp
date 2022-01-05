<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	li {list-style: none; float: left; padding: 6px;}
</style>
<form method="post">
<div class="container-900 container-center">

<input type="checkbox" name="lecLocRegion" value="서울">
서울
<input type="checkbox" name="lecLocRegion" value="경기도">
경기도
<input type="checkbox" name="lecLocRegion" value="제주도">
제주도
<input type="checkbox" name="lecLocRegion" value="강원도">
강원도
<input type="checkbox" name="lecLocRegion" value="인천">
인천
	
 	장소 : <input type="text" name="lecLocRegion">
 	<select></select>
 	
 	강좌 제목 :	<input type="text" name="lecName"> 
 	강사 이름 : <input type="text" name="memberNick">
 	<input type="submit" value="검색하기">
 	
	<div class="row">
		<h2>강좌 검색</h2>
	</div>
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>No</th>
					<th>카테고리</th>
					<th>강좌 이름</th>
					<th>강사</th>
					<th>수강료</th>
					<th>수강 인원</th>
					<th>좋아요</th>
					<th>강의수</th>
					<th>강좌시작날짜</th>
					<th>강좌종료날짜</th>
					<th>지역</th>
					<c:if test="${memberGrade == admin}">
						<th>메뉴</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="lecListVO" items="${list}">
				<tr>
					<td>${lecListVO.lecIdx}</td>
					<td>${lecListVO.lecCategoryName}</td>
					<td><a href="detail/${lecListVO.lecIdx}">${lecListVO.lecName}</a></td>
					<td>${lecListVO.memberNick}</td>
					<td>${lecListVO.lecPrice}</td>
					<td>${lecListVO.lecHeadCount}</td>
					<td>${lecListVO.lecLike}</td>
					<td>${lecListVO.lecContainsCount}</td>
					<td>${lecListVO.lecStart}</td>
					<td>${lecListVO.lecEnd}</td>
					<td>${lecListVO.lecLocRegion}</td>
					<td>
					<c:if test="${memberGrade == admin}">
						<a href="edit?lecIdx=${lecDto.lecIdx}">수정</a>
						<a href="delete?lecIdx=${lecDto.lecIdx}">삭제</a>
					</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</form>

<nav class="row pt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageMaker.prev}">
    	<li class="page-item "><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">&laquo;</a></li>
    </c:if> 

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
<!--     
만약에 현재페이지면 *미완성*
<li class="page-item active"><a class="page-link" href="#">1</a></li>
 -->
    	<li class="page-item"><a  class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">&raquo;</a></li>
    </c:if> 
  </ul>
</nav>	