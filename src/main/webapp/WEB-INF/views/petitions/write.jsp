<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<form method="post" enctype="multipart/form-data">
<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="petitionsName" required></td>
			
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="petitionsDetail" required rows="10" cols="60"></textarea>
			</td>
		</tr>
		<tr>
			<th>첨부</th>
			<td>
				<input type="file" name="attach" enctype="multipart/form-data" multiple>
			</td>
		</tr>
		</tbody>
	<tfoot>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="등록">
			</td>
		</tr>
		
	</tfoot>
</table>
</form>