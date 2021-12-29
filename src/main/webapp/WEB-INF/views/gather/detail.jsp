<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>

 
<h2>${GatherVO.gatherIdx}번 게시글 </h2>

<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${GatherVO.gatherName}</h3>
			</td>
		</tr>
		<tr>
			<td>
				작성자 :${GatherVO.memberNick}
				|
				장소 : ${GatherVO.gatherLocRegion}
			</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td>
				<pre>${GatherVO.gatherDetail}</pre>
			
				
			<c:forEach var="GatherFileDto" items="${list}"> 
<img src="file?gatherFileIdx=${GatherFileDto.gatherFileIdx}" width="50%" 
class="image image-round image-border">
</c:forEach>
			
			
<%-- 	<img src="file?gatherFileIdx=${gatherFileDto.gatherFileIdx}" width="50%"  --%>
<!-- 	class="image image-round image-border"> -->
			</td>
		</tr>
		<tr>
		<td>
				<a href="insert">글쓰기</a>
				<a href="list">목록보기</a>
				<a href="#">수정</a>			
				<a href="delete?gatherIdx=${GatherVO.gatherIdx}">삭제</a>	
	
			</td>
		</tr>
	</tbody>
</table>





