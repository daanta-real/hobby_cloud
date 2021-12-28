<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>파일 업로드 화면</h1>

<form action="upload" method="post"
				enctype="multipart/form-data">
	
	ID : <input type="text" name="memberId">
	<br><br>
	PW : <input type="text" name="memberPw">
	<br><br>
	Profile : <input type="file" name="attach">
	<br><br>
	<input type="submit">
		
</form>

<h1>파일 업로드 화면(multiple)</h1>

<form action="upload2" method="post"
				enctype="multipart/form-data">
	
	ID : <input type="text" name="memberId">
	<br><br>
	PW : <input type="text" name="memberPw">
	<br><br>
	Profile : <input type="file" name="attach" multiple>
	<br><br>
	<input type="submit">
		
</form>

<h1>파일 업로드 화면(vo)</h1>

<form action="upload3" method="post"
				enctype="multipart/form-data">
	
	ID : <input type="text" name="memberId">
	<br><br>
	PW : <input type="text" name="memberPw">
	<br><br>
	Profile : <input type="file" name="attach" multiple>
	<br><br>
	<input type="submit">
		
</form>