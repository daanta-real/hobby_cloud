<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>공지 게시판</h1>
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
		<c:forEach var="NoticeVO" items="${list}">
			<tr>
				<td>${NoticeVO.noticeIdx}</td>
				<td align="left">
				<a href="detail/${NoticeVO.noticeIdx }">${NoticeVO.noticeName }</a>
				</td>
				<td>${NoticeVO.memberNick }</td>
				<td>${NoticeVO.noticeRegistered }</td>
				<td>${NoticeVO.noticeViews }</td>
				<td>${NoticeVO.noticeReplies }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<br>
<a href="write">글쓰기</a>

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
