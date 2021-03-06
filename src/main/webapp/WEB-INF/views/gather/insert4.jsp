<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b
&libraries=services"></script>
<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet"
	href="https://bootswatch.com/5/journal/bootstrap.css">
<!-- Bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">
<!-- JQuery 3.6.0 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- XE Icon -->
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<style>
#map {
	width: 500px;
	height: 400px;
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
					$("input[name=gatherLocRegion]").val(
							result[0].address.address_name);
					var address = $("input[name=gatherLocRegion]").val();

					//2. 카카오 장소변환 샘플 코드를 복사 후 일부 수정
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(address, function(result, status) {
						var coords = new kakao.maps.LatLng(result[0].y,
								result[0].x);
						
						$("input[name=gatherLocLongitude]").val(result[0].y);
						$("input[name=gatherLocLatitude]").val(result[0].x);

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

<script type='text/javascript'>

// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", () => {
	
    // 모달 변수 정의
    window.modal = new bootstrap.Modal(document.getElementById("modal"), {
        keyboard: false
    });

});

// 라이브러리: 이벤트 버블링 막기
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

// TR로부터 지역/위도/경도값을 취해 FORM INPUT 안에 넣어주는 함수
function setLoc(el) {

    // 이벤트 버블링 막기
    stopEvent();

    // 내가 클릭한 TR 태그로부터 값 추출
    const data = {
        idx      : el.getAttribute("data-idx"),
        region   : el.getAttribute("data-region"),
        longitude: el.getAttribute("data-longitude"),
        latitude : el.getAttribute("data-latitude")
    };

    // 추출된 값을 각 INPUT 태그에 넣어주기
//     document.querySelector("input[name='loc_idx']"      ).value = data.idx;
    document.querySelector("input[name='gatherLocRegion']"   ).value = data.region;
    document.querySelector("input[name='gatherLocLatitude']").value = data.longitude;
    document.querySelector("input[name='gatherLocLongitude']" ).value = data.latitude;
    
    // 모달 토글
    modal.toggle();

}

</script>

        <script>
				function makeTime(){
					let startDate= $("#startDate").val(); // YYYY-MM-DD
					let startTime=  $("#startTime").val();// 24HH:mm		
					let start = startDate + " " + startTime;		
					$("#start").val(start);
					let endDate = $("#endDate").val();
					let endTime =$("#endTime").val();
					let end = endDate +" "+endTime;
					$("#end").val(end);
					
				}
				$(function(){
					$("#insert-btn").click(function(e){
					//시간설정 잘못 된 것
					makeTime(); 
					let startTime = new Date($("#start").val());
			        let endTime    = new Date($("#end").val());
			        let today = new Date();
			             //빈칸일 경우
// 					"input[name=]").val()==""||
// 					$("input[name=]").val()==""||
// 					$("input[name=]").val()==""||
// 					$("input[name=]").val()==""||
// 					$("input[name=]").val()==""
						if(endTime>startTime&&startTime>today)
						{  
							
							e.preventDefault();
							makeTime();
							  $("#insert-form").submit();
   						} else{
		                e.preventDefault();		
		                alert("시간 설정을 확인해주세요");
		                console.log(endTime);      
						console.log(startTime);
						console.log(today);
						console.log(endTime >startTime);
						console.log(startTime>today);
						console.log(endTime>startTime>today);  
   						}	    
					});
		        });
				</script>




<h1>소모임 등록창</h1>
<div id="map"></div>

<form action="insert" method="post" enctype="multipart/form-data" id="insert-form">


	
	 취미분류 <input type="text" name="lecCategoryName" value="운동">
	  <br>
	장소 idx<input id="placeIdxHolder" type="hidden" name="placeIdx"	value="9999">
	 제목	<input type="text" name="gatherName"value="제목"> 
		상세내용<input type="text" name="gatherDetail" value="내용"> <br>
		 작성일<input type="date"	name="gatherRegistered"> 
		인원<input type="text"	name="gatherHeadCount" value="1">
		 지역<input type="text"	name="gatherLocRegion" value="지역">
		 <br> 
		 위도<input	id="placeLatiHolder" type="text" name="gatherLocLatitude">
		 경도<input id="placeLongHolder" type="text" name="gatherLocLongitude">
		
		 시작시간<input id="startDate" type="date">
		 	 <input id="startTime" type="time">
		 <input id="start" type="hidden" name="gatherStart">
		<br>
		 종료시간 	<input id="endDate" type="date">
		 		<input id="endTime" type="time">
		<input id="end" type="hidden" name="gatherEnd">
		 최대원인원수<input	type="text" name="gatherMax" value="1">
		 현재오픈여부 <input	type="text" name="gatherStaus" value="1"> <br>
		 
		 <input type="file" name="attach" enctype="multipart/form-data" multiple>
		<input id="insert-btn" type="submit" value="전송하기">
	 <br> 
	
	</form>






<!-- 모달 여는 버튼 -->
<button type="button" id="showList"class="btn btn-primary m-3 p-3" data-bs-toggle="modal" data-bs-target="#modal">모달 열기</button>

<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->
<div id="modal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <!-- 모달 제목 영역 -->
            <div class="modal-header">
                <!-- 모달 타이틀 -->
                <h5 class="modal-title">장소를 고르세요.</h5>
                <!-- 모달 닫기 버튼 -->
                <!-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. -->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- 모달 본문 영역 -->
            <table class="modal-body table table-striped">
                <thead>
                    <tr>
                        <th scope="col" class="text-center">순</th>
                        <th scope="col" class="text-center">이름</th>
                        <th scope="col" class="text-center">지역</th>
                    </tr>
                </thead>
                <tbody class="locTBody">
                <!-- ajax로 리스트 목록이 나오는 장소 -->
                </tbody>
            </table>
            <!-- 모달 꼬리말 영역 -->
        </div>
    </div>
</div>





<script>
	$(function() {
		$("#showList").click(function() {
						$.ajax({
						url : "${pageContext.request.contextPath}/gatherData/gatherList",
						type : "get",
						dataType : "json",
						success:function(resp){
							
							console.log("성공", resp);
							var results = resp;
							console.log(results);
							
							var totalStr = "";
							$.each(results, function(i) {
								var jsonStr = results[i];
								console.log(i + "번째 TR: ", jsonStr);
								totalStr += '<tr scope="row" data-idx="' + jsonStr.gatherIdx + '"'
									+ ' data-region="'+jsonStr.gatherLocRegion+'" data-longitude="'+jsonStr.gatherLocLongitude+'"'
									+ ' data-latitude="' + jsonStr.gatherLocLatitude+'"'
									+ ' onclick="setLoc(this)">'
									+ '<td class="text-center">' + jsonStr.gatherIdx +'</td>'
									+ '<td class="text-center">' + jsonStr.gatherName +'</td>'
									+ '<td>' + jsonStr.gatherLocRegion +'</td></tr>';
							});
							console.log("전체 HTML: ", totalStr);
							
							var listTarget = document.querySelector(".locTBody");
							listTarget.innerHTML = totalStr;
							
						},
						error : function(e) {
						console.log("실패", e);
									}
								});
						});
	});
</script>