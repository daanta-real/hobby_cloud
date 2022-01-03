<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<FOOTER class='container-fluid mt-md-5 mt-sm-3 p-lg-3 p-md-1 text-secondary'>
	<div class="row">
		<ul class="container list-unstyled">
			<li class="row m-1">회사소개 | 이용약관 | 개인정보처리방침 | 사업자 정보확인 | 콘텐츠산업진흥법에의한 표시</li>
			<li class="row m-1 mt-lg-4 mb-lg-4 mt-md-0 mb-md-0">고객행복센터 1355-4533 오전 9시 - 새벽 3시</li>
			<li class="row m-1">(주) 하비클라우드컴퍼니</li>
			<li class="row m-1">주소 : 서울특별시 강남구 강남대로 001, 777타워 77층</li>
			<li class="row m-1">대표이사 : 왕인빈 | 사업자등록번호: 001-01-00334</li>
			<li class="row m-1">통신판매번호 : 2021-서울강남-01001 | 관광사업자 등록번호: 제1001-01호</li>
			<li class="row m-1">전화번호 : 1355-4533</li>
			<li class="row m-1">전자우편주소 : welcome@hobbycloud.kr</li>
			<li class="row m-1">Copyright HobbyCloud Corp. All rights reserved</li>
			<li class="row m-1">로그인 정보: No. ${sessionScope.memberIdx} ${sessionScope.memberNick}님 (${sessionScope.memberId} - ${sessionScope.memberGrade}등급)</li>
		</ul>
	</div>
</FOOTER>