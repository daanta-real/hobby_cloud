<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">    
    
<!-- 
	회원이 강사 신청을 하게되면
	관리자가 직접 회원 상세보기 페이지에서 강사 등록 버튼을 누른 화면
	(강사 등록 버튼을 누르면 파라미터값으로 memberIdx를 전달해주시기 바랍니다!)
-->
<h1>강사 등록하기</h1>
<form method="post" >
	${memberDto.memberNick} 회원을 강사로 등록하시겠습니까?
	<input type="hidden" name="memberIdx" value="${memberDto.memberIdx}">
	<input type="submit" class="btn btn-danger" value="등록하기">
</form>