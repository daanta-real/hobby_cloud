<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type=text/css>
* {margin:10px;}
</style>
</head>
<body>

<form method=post class="form-input" style="display:flex; flex-direction:column;">

	<!-- 체크박스 -->
	<label><input type=checkbox name=chkbox value=1>1</label>
	<label><input type=checkbox name=chkbox value=2>2</label>
	<label><input type=checkbox name=chkbox value=3>3</label>
	
	<!-- 텍스트 -->
	<input type=text name=text placeholder=텍스트입력 />
	
	<!-- 파일 -->
	<input type=file data-idx=1 name=attach1 />
	<input type=file data-idx=2 name=attach2 />
	<input type=file data-idx=3 name=attach3 />
	
	<button>제출</button>
	
</form>

</body>
</html>