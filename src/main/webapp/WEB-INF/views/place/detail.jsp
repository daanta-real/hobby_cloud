<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
       src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services"></script>
   
   
<script>
   $(function() {
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center : new kakao.maps.LatLng(
				$("input[name=lecLocLatitude]").val(),
				$("input[name=lecLocLongitude]").val()
			),
			level : 3
		};
	
		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);
	
		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(
			$("input[name=lecLocLatitude]").val(),
			$("input[name=lecLocLongitude]").val()
		);
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	});
</script> 
    
    
<h2 id="placeIdxValue" data-place-idx="${placeRegisterVO.placeIdx}">${placeRegisterVO.placeName} 강좌 상세 </h2>

<br>

<!-- 장소 추가하기 -->
<a href="${pageContext.request.contextPath}/lec/check/${placeRegisterVO.lecIdx}" class="btn btn-danger">강좌 신청</a>
<br>

<h2>장소 상세</h2>
<div class="row">
	<c:choose>
		<c:when test="${list == null}">
		<img src="https://via.placeholder.com/300x500?text=User" width="50%" class="image">
		</c:when>
		<c:otherwise>
		<c:forEach var="LecFileDto" items="${list}"> 
			<img src="${pageContext.request.contextPath}/place/placeFile/${placeFileDto.placeFileIdx}" width="50%" 
			class="image image-round image-border">
		</c:forEach>
		</c:otherwise>
	</c:choose>
</div>

<h2>장소 정보</h2>
<!-- 여기에 장소 표시할 지도 들어갈거임 -->
<!--상세페이지 지도 -->
<input type="text" name="placeLocLongitude" value="${placeRegisterVO.placeLocLongitude}">
<input type="text" name="placeLocLatitude"  value="${placeRegisterVO.placeLocLatitude}">
<div id="map" style="width:50%;height:350px;"></div>
<table border="1" width="80%">
	 <tbody>
	     <tr>
	         <td>장소 이름</td>
	         <td>${placeRegisterVO.placeName}</td>
	     </tr>
	     <tr>
	         <td>지역 설명</td>
	         <td>${placeRegisterVO.placeDetail}</td>
	     </tr>
	     <tr>
	         <td>강의장 용도</td>
	         <td>${placeRegisterVO.placeDetail}</td>
	     </tr>
	     <tr>
	         <td>카카오에서 선택한 지역</td>
	         <td>${placeRegisterVO.placeLocRegion}</td>
	     </tr>
	     <tr>
	         <td>카카오에서 선택한 위도</td>
	         <td>${placeRegisterVO.placeLocLatitude}</td>
	     </tr>
	     <tr>
	         <td>카카오에서 선택한 경도</td>
	         <td>${placeRegisterVO.placeLocLongitude}</td>
	     </tr>
	 </tbody>
</table>

<br>

<h2>강사 정보</h2>

<table border="1" width="80%">
	 <tbody>
	     <tr>
	         <td>강사 등록일</td>
	         <td>${placeRegisterVO.tutorRegistered}</td>
	     </tr>
	     <tr>
	         <td>강사 이름</td>
	         <td>${placeRegisterVO.memberNick}</td>
	     </tr>
	     <tr>
	         <td>강사 이메일</td>
	         <td>${placeRegisterVO.memberEmail}</td>
	     </tr>
	     <tr>
	         <td>강사 번호</td>
	         <td>${placeRegisterVO.memberPhone}</td>
	     </tr>
	 </tbody>
</table>

<hr>

<a href="${pageContext.request.contextPath}/place/list">목록보기</a>
<a href="${pageContext.request.contextPath}/place/update/${placeRegisterVO.placeIdx}">수정</a>			
<a href="${pageContext.request.contextPath}/place/delete/${placeRegisterVO.placeIdx}">삭제</a>	
