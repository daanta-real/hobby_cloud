<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<input type="hidden" name="noticeIdx" value="${noticeVO.noticeIdx }">
<input type="hidden" name="noticeIdx" value="${noticeDto.noticeIdx }">

<h2>${noticeVO.noticeIdx}번 게시글</h2>

<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${noticeVO.noticeName }</h3>
			</td>
		</tr>
		<tr>
			<td>
				등록일 : ${noticeVO.noticeRegistered}
				|
				작성자 : ${noticeVO.memberNick}
				|
				조회수 : ${noticeVO.noticeViews}
			</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td>
				<pre>${noticeVO.noticeDetail }</pre>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="write">글쓰기</a>
				<a href="list">목록보기</a>
				<a href="edit?noticeIdx=${noticeVO.noticeIdx }">수정하기</a>
				<a href="delete?noticeIdx=${noticeVO.noticeIdx }">삭제하기</a>
	
	</tbody>
</table>