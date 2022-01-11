<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51857ee590e6cc2b1c3f4879f1fdf7b2&libraries=services,clusterer,drawing"></script>
<script>
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




    
    
<h2 id="placeIdxValue" data-place-idx="${placeVO.placeIdx}">${placeVO.placeName} 강좌 상세 </h2>

<br>

<!-- 장소 추가하기 -->
<a href="${pageContext.request.contextPath}/place/check/${placeVO.placeIdx}" class="btn btn-danger">강좌 신청</a>
<br>

<h2>장소 상세</h2>
<div class="row">
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

<h2>장소 정보</h2>
<!-- 여기에 장소 표시할 지도 들어갈거임 -->
<!--상세페이지 지도 -->
<input type="text" name="placeAddress" value="${placeVO.placeAddress}">
<input type="text" name="placeName"  value="${placeVO.placeName}">
<div id="map" style="width:100%;height:350px;"></div>
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
