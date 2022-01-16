<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="isAdmin" value="${sessionScope.memberGrade == '관리자'}" />
<c:set var="isLocManager" value="${sessionScope.memberGrade == '장소관리자' || sessionScope.memberGrade == '관리자'}" />
<!DOCTYPE HTML>
<HTML LANG="ko">

<c:forEach items="list" var="one">
	${one[0]}
</c:forEach>

</HTML>
