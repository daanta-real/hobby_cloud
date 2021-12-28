
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>게시글 수정</h2>

<form method="post">
<input type="hidden" name="noticeIdx" value="${noticeVO.noticeIdx }">

<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="noticeName" required value="${noticeVO.noticeName }"></td>
			
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="noticeDetail" required 
					rows="10" cols="60">${noticeVO.noticeDetail }</textarea>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="수정">
			</td>
		</tr>
	</tfoot>
</table>
	
</form>

