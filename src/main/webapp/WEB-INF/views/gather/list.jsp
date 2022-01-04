<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/resources/template/header.jsp" flush="false" />
	 	<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
		</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services"></script>
<script>
	$(function() {
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center : new kakao.maps.LatLng(37.5339851357212, 126.897094049199),
			level : 8
		};
		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);

		// 마커의 위치 , 내용을 가지고 있는 객체 배열입니다
		var positions = [

		];
		var markers = [];
		
		for (var i = 0; i < $(".fgTitle").length; i++) {
			let title = $(".fgTitle").eq(i).val();
			let latti = Number($(".fgLatitude").eq(i).val());
			let longdi = Number($(".fgLongitude").eq(i).val());
			console.log($(".fgTitle").eq(i).val());
			console.log($(".fgLatitude").eq(i).val());
			console.log($(".fgLongitude").eq(i).val());
		
			positions.push({
				content : title ,
				latlng : new kakao.maps.LatLng(latti,longdi)
			});			
		}
		
		for (var i = 0; i < positions.length; i++) {
			addMarker(positions[i]);
			
		}

		//마커 생성 함수 + 클릭 이벤트 추가 함수 
		function addMarker(position){
			var marker = new kakao.maps.Marker({
				map : map, // 마커를 표시할 지도
				position : position.latlng
			
			});
			
			// 마커에 표시할 인포윈도우를 생성합니다 
			var infowindow = new kakao.maps.InfoWindow({
					content : position.content
				// 인포윈도우에 표시할 내용
				});
			
			kakao.maps.event.addListener(marker, 'click', function() {
	
				var lat = marker.getPosition().getLat();
				var lng = marker.getPosition().getLng();
				setCenter(lat,lng);

			});
			// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			// 이벤트 리스너로는 클로저를 만들어 등록합니다 
			// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
					map, marker, infowindow));
			kakao.maps.event.addListener(marker, 'mouseout',
					makeOutListener(infowindow));
			
		}
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			};
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			}; 
		}
		
	 	function setCenter(lat,lng) {            
			
		    var moveLatLon = new kakao.maps.LatLng(lat,lng);
		    map.setLevel(3);
		    // 지도 중심을 이동 시킵니다
		    map.setCenter(moveLatLon);
		}
		
		
	});
</script>
		
<div id="map" style="width: 800px; height: 300px; border-radius: 20px;"></div>	
		
<form  method="post">


<!--  제목 검색:	<input type="text" name="title">  -->
 <input type="checkbox" name="gatherLocRegion" value="제주">제주도
  <input type="checkbox" name="gatherLocRegion" value="강원">강원도
 <input type="text" name="gatherName">
  <input type="checkbox" name="category" value="운동">운동
  <input type="checkbox" name="category" value="미술">미술
   <input type="checkbox" name="category" value="음악">음악


 <input type="submit" value="검색하기">
 
 <a href="${pageContext.request.contextPath}/gather/insert">글쓰기</a>
</form>





<table border="1" width="90%">
	<thead>
		<tr>
		<th width="30%">사진></th>
			<th>번호</th>
			<th >제목</th>
			<th>작성자</th>
			<th>지역</th>
			<th>인원</th>
			<th>제목</th>
		</tr>
	</thead>


	<tbody align="center">
		<c:forEach var="GatherVO" items="${list}">
			<tr>
			
			<td>
			<img src="${pageContext.request.contextPath}/gather/file/${GatherVO.gatherFileIdx}" width="20%">
			</td>
			
				<td>${GatherVO.gatherIdx}</td>
				<td align="left">
				<a href="${pageContext.request.contextPath}/gather/detail/${GatherVO.gatherIdx }">${GatherVO.gatherName }</a>
				</td>
				<td>${GatherVO.memberNick }</td>
				<td>${GatherVO.gatherLocRegion }</td>
				<td>${GatherVO.gatherHeadCount }</td>
				<td>${GatherVO.gatherName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
			<nav class="row pt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageMaker.prev}">
    	<li class="page-item "><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">&laquo;</a></li>
    </c:if> 

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
<!--     
만약에 현재페이지면 *미완성*
<li class="page-item active"><a class="page-link" href="#">1</a></li>
 -->
    	<li class="page-item"><a  class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">&raquo;</a></li>
    </c:if> 
  </ul>
</nav>	
