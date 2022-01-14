<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
});

<script type="text/javascript">
$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	//주소로 좌표를 검색합니다
	geocoder.addressSearch('${placeVO.placeAddress}', function(result, status) {
	// 정상적으로 검색이 완료됐으면 
	 if (status === kakao.maps.services.Status.OK) {
	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: coords
	    });
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">${placeVO.placeName}</div>'
	    });
	    infowindow.open(map, marker);
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	} 
	});    
});
</script>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />



<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->

<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			${placeVO.placeName} 강의장 상세페이지
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		
		<!-- 소단원 내용 -->    
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
			<div class="form-group col-12 text-center">
			<!-- 강의장 이미지 -->
				<c:choose>
					<c:when test="${list == null}">
					<img src="https://via.placeholder.com/300x500?text=User" width="50%" class="image">
					</c:when>
					<c:otherwise>
					<c:forEach var="PlaceFileDto" items="${list}"> 
						<img src="${pageContext.request.contextPath}/place/placeFile/${PlaceFileDto.placeFileIdx}" width="50%" 
						class="image image-round image-border">
					</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group col-12 text-center">
				<!-- 여기에 장소 표시할 지도 들어갈거임 -->
				<!--상세페이지 지도 -->
				<div class="form-group col-12">
				<label class="form-label" for="disabledInput">장소 상세사진</label>
				<input type="text" name="placeAddress" value="${placeVO.placeAddress}">
				<input type="text" name="placeName"  value="${placeVO.placeName}">
				<div id="map" style="width:100%;height:350px;"></div>
			</div>
				<table border="1" width="80%">
					 <tbody>
					     <tr>
					         <td>장소 이름</td>
					         <td>${placeVO.placeName}</td>
					     </tr>
					     <tr>
							<td>강의장 대여자 닉네임</td>
							<td>${placeVO.memberNick}</td>
					    </tr>
					     <tr>
					         <td>장소 설명</td>
					         <td>${placeVO.placeDetail}</td>
					     </tr>
					     <tr>
					         <td>강의장 사용 카테고리</td>
					         <td>${placeVO.lecCategoryName}</td>
					     </tr>
					     <tr>
					         <td>강의장 주소</td>
					         <td>${placeVO.placeAddress}</td>
					     </tr>
						<tr>
							<td>강의장 대여 시작일</td>
							<td>${placeVO.placeStart}</td>
					    </tr>
					    		<tr>
							<td>강의장 대여 마감일</td>
							<td>${placeVO.placeEnd}</td>
					    </tr>
					    <tr>
							<td>강의장 대여 최소 금액</td>
							<td>${placeVO.placeMin}</td>
					    </tr>
					    <tr>
							<td>강의장 대여 최대 금액</td>
							<td>${placeVO.placeMax}</td>
					    </tr>
					    <tr>
							<td>강의장 문의 이메일</td>
							<td>${placeVO.placeEmail}</td>
					    </tr>
					    <tr>
							<td>강의장 문의 전화</td>
							<td>${placeVO.placePhone}</td>
					    </tr>
					    <tr>
					         <td>강의장 등록일</td>
					         <td>${placeVO.placeRegistered}</td>
					     </tr>
					 </tbody>
				</table>
				
				<br>
				
				<hr>
				
				<a href="${pageContext.request.contextPath}/place/list">목록보기</a>
				<a href="${pageContext.request.contextPath}/place/update/${placeVO.placeIdx}">수정</a>			
				<a href="${pageContext.request.contextPath}/place/delete/${placeVO.placeIdx}">삭제</a>	
