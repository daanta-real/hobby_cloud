<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 출력 --%>

<h2>회원 정보 수정</h2>

<form method="post">
	
	<table class="table">
		<tbody>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="memberPw" required>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="memberNick" required value="${memberDto.memberNick}">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" name="memberEmail" value="${memberDto.memberEmail}">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="tel" name="memberPhone" value="${memberDto.memberPhone}">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정">
				</td>
			</tr>
		</tbody>
	</table>
	
</form>

<c:if test="${param.error != null}">
<h4><font color="red">비밀번호가 일치하지 않습니다</font></h4>
</c:if>







