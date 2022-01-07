<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<h1>결제 페이지</h1>

<h2>${lecDetailVO.lecName} 강좌 정보</h2>
<table border="1" width="80%">
	 <tbody>
	     <tr>
	         <td>카테고리</td>
	         <td>${lecDetailVO.lecCategoryName}</td>
	         <td>지역</td>
	         <td>${lecDetailVO.placeName}</td>
	     </tr>
	     <tr>
	         <td>강사명</td>
	         <td>${lecDetailVO.memberNick}</td>
	         <td>수강인원</td>
	         <td>${lecDetailVO.lecHeadCount} 명</td>
	     </tr>
	     <tr>
	         <td>기간</td>
	         <td>${lecDetailVO.lecStart} ~ ${lecDetailVO.lecEnd}</td>
	         <td>수강료</td>
	         <td>${lecDetailVO.lecPrice}</td>
	     </tr>
	     <tr>
	     	<td>강좌 상세</td>
	     	<td>${lecDetailVO.lecDetail}</td>
	     </tr>
	 </tbody>
	 
</table>

<h2>강사 정보</h2>
<table border="1" width="80%">
	 <tbody>
	     <tr>
	         <td>강사 등록일</td>
	         <td>${lecDetailVO.tutorRegistered}</td>
	     </tr>
	     <tr>
	         <td>강사 이름</td>
	         <td>${lecDetailVO.memberNick}</td>
	     </tr>
	     <tr>
	         <td>강사 이메일</td>
	         <td>${lecDetailVO.memberEmail}</td>
	     </tr>
	     <tr>
	         <td>강사 번호</td>
	         <td>${lecDetailVO.memberPhone}</td>
	     </tr>
	 </tbody>
</table>

<form action="post">
	현재 ${memberDto.memberNick} 회원님께서는
	${memberDto.memberPoint}의 포인트를 보유중이며
	강좌 추가시 ${lecDetailVO.lecPrice} 포인트가 소모됩니다.
	강좌를 추가하려면 비밀번호를 입력해주세요
<!-- 	<input type="hidden" name="member_idx"> -->
	<input type="password" name="memberPw">
	<input type="submit" class="btn" value="추가하기">
	<!-- 만약 포인트가 모자라면 포인트가 부족합니다! 경고 띄우면서
			포인트 결제 페이지로 이동? 은 기분이 나쁠 수 있으니 포인트가 부족합니다! 실패 페이지로 이동 -->
</form>