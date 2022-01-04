<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>


<h2>${PetitionsVO.noticeIdx}번 게시글</h2>

<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${PetitionsVO.petitionsName }</h3>
			</td>
		</tr>
		<tr>
			<td>
				등록일 : ${PetitionsVO.petitionsRegistered}
				|
				작성자 : ${PetitionsVO.petitionsNick}
				|
				조회수 : ${PetitionsVO.petitionsViews}
			</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td>
				<pre>${PetitionsVO.petitionsDetail }</pre>
				<c:forEach var="PetitionsFileDto" items="${list}"> 
<img src="${pageContext.request.contextPath}/petitions/file/${PetitionsFileDto.petitionsFileIdx}" width="30%" 
class="image image-round image-border">
</c:forEach>
			</td>
		</tr>
		<tr>
			<td align="right">
			<c:if test="${admin }">
				<a href="write">글쓰기</a>
				</c:if>
				<a href="${pageContext.request.contextPath}/notice/list">목록보기</a>
				<c:if test="${admin }">
				<a href="${pageContext.request.contextPath}/notice/edit?noticeIdx=${PetitionsVO.petitionsIdx }">수정하기</a>
				<a href="${pageContext.request.contextPath}/notice/delete?noticeIdx=${PetitionsVO.petitionsIdx }">삭제하기</a>
				</c:if>
	
	</tbody>
</table>