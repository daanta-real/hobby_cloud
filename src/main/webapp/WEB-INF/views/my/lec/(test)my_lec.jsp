<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>내 강좌</h1>

<c:forEach var="lecMyVO" items="${myLecList}">
	카테고리 : ${lecMyVO.lecCategoryName}
	강좌 이름 : ${lecMyVO.lecName}
	강사 이름 : ${lecMyVO.memberNick}
	강좌 수 : ${lecMyVO.lecContainsCount}
	강좌 지역 : ${lecMyVO.lecLocRegion}
	강좌 시작 날짜 : ${lecMyVO.lecStart}
	강좌 종료 날짜 : ${lecMyVO.lecEnd}
</c:forEach>
