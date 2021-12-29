<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b
&libraries=services"></script>
<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet" href="https://bootswatch.com/5/journal/bootstrap.css">
<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<!-- JQuery 3.6.0 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- XE Icon -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<
	<style>
		#map {
			width:500px;
			height:400px;
		}
	</style>
	
<script>
	$(function() {
	
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center : new kakao.maps.LatLng(37.5339851357212, 126.897094049199),
			level : 4
		};

		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);
		$(".search-btn").click(
				function() {
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다

					geocoder.addressSearch($("input[name=keyword]").val(),
							function(result, status) {

								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {

									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
				});
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new kakao.maps.InfoWindow({
			zindex : 1
		}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			searchDetailAddrFromCoords(mouseEvent.latLng, function(result,
					status) {
				if (status === kakao.maps.services.Status.OK) {
					var detailAddr = !!result[0].road_address ? '<div>도로명주소 : '
							+ result[0].road_address.address_name + '</div>'
							: '';
					detailAddr += '<div>지번 주소 : '
							+ result[0].address.address_name + '</div>';

					var content = '<div class="bAddr">'
							+ '<span class="title">법정동 주소정보</span>'
							+ detailAddr + '</div>';

					// 마커를 클릭한 위치에 표시합니다 
					marker.setPosition(mouseEvent.latLng);
					marker.setMap(map);

					// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
					infowindow.setContent(content);
					infowindow.open(map, marker);
					$("input[name=fgLocation]").val(
							result[0].address.address_name);
					var address = $("input[name=fgLocation]").val();

					//2. 카카오 장소변환 샘플 코드를 복사 후 일부 수정
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(address, function(result, status) {
						var coords = new kakao.maps.LatLng(result[0].y,
								result[0].x);

						$("input[name=fgLatitude]").val(result[0].y);
						$("input[name=fgLongitude]").val(result[0].x);

					});
				}
			});
		});

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
					callback);
		}

		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);

		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');

				
			}
		}
	});
</script>  
    <script>
    
$(function(){
	$("#hello").click(function(){
		console.log("헬로");
		 var radioVal = $('input[name="pratice"]:checked').val();
		$("input[name=device]").val(radioVal);
	});
});
</script>
    
    
<script>
$(function(){
List a = new List();//담는 객체 

//받는 객체 =  List  a = [ {"key":value,"key2":value2},{},{},{} , {}  ]
// let val= a[0].key; (value) 
	$("#showList").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/gatherData/gatherList",
			type:"get",
			dataType:"json",
			success:function(resp){
				console.log("성공",resp);
				for(var i=0; i< resp.length; i++){
					var template = $("#gather-template").html();
					// 장소 목록 가져오기
					template = template.replace("{{gatherIdx}}",resp[i].gatherIdx);
					console.log(resp[i].gatherIdx);
					template = template.replace("{{gatherLocRegion}}",resp[i].gatherLocRegion);
					console.log(resp[i].gatherLocRegion);
					
					$("#result").append(template);
				}
			},
			error:function(e){
				console.log("실패",e);
			}
			
		});
	});
});
</script> 
<button id="hello">버튼</button>
    
<h1>소모임 등록창</h1>
<div id="map"></div>
<button onclick="window.open('list',
		'window_name','width=430,height=500,location=no,status=no,scrollbars=yes');">
		button</button>

<form method="post" enctype="multipart/form-data">


회원 idx<input type="text" name="memberIdx" value="99999">
취미분류 이름<input type="text" name="lecCategoryName" value="운동">
<br>
장소 idx<input type="text" name="placeIdx" value="9999">
제목<input type="text" name="gatherName" value="제목">
상세내용<input type="text" name="gatherDetail" value="내용">
<br>
작성일<input type="date" name="gatherRegistered">
인원<input type="text" name="gatherHeadCount" value="1">
지역<input type="text" name="gatherLocRegion" value="지역">
<br>
위도<input type="text" name="gatherLocLatitude" value="123">
경도<input type="text" name="gatherLocLogitude" value="456">
시작시간<input type="date" name="gatherStart" >
<br>
종료시간<input type="date" name="gatherEnd">
최대원인원수<input type="text" name="gatherMax" value="1">
현재오픈여부<input type="text" name="gatherStaus" value="1">
<br>
<input type="file" name="attach" enctype="multipart/form-data" multiple>
<input type="submit" value="전송하기">
<br>
자식에서 가져온 값:<input type="text" name="device">
</form>

<!-- Button trigger modal -->
<button type="button" id="showList" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">장소 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      
     <!-- 모듈창 안의 내용 -->
      <input type="text" name="pratice">2
       <input type="radio" name="pratice" value="hello">장소1
      <div class="modal-body">
      <div id="result"></div>
     <template id="gather-template">
  	<div>
 
     <!--<span>{{gatherIdx}} {{gatherLocRegion}}}</span> -->
    </div>
     </div>
     </template> 
    
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button"  id="hello" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<!-- 
1.버튼 클릭 시 jquery 실행
2.모달창 띄운 뒤 ajax로 내용 채우기 (function)
3.목록에서 클릭 시 내용 가져오기
 -->


<!--클릭하면 -->






 