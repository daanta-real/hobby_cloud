<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>내 강좌</h1>

<c:forEach var="myLecVO" items="${myLecList}">
	카테고리 : ${myLecVO.lecCategoryName}
	강좌 이름 : ${myLecVO.lecName}
	강사 이름 : ${myLecVO.memberNick}
	강좌 수 : ${myLecVO.lecContainsCount}
	강좌 지역 : ${myLecVO.lecLocRegion}
	강좌 시작 날짜 : ${myLecVO.lecStart}
	강좌 종료 날짜 : ${myLecVO.lecEnd}
</c:forEach>
