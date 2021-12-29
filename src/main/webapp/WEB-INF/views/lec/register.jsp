<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=04960945d1766f88ab55dee4b1108961&libraries=services"></script>
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

<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>강좌 등록</h1>
	</div>
	<div class="row">
		<label>강좌 이름</label>
		<input type="text" name="lecName" required class="form-input">
	</div>
	<div class="row">
		<label>카테고리</label>
		<select name="lecCategoryName" required class="form-input">			
			<option value="">선택하세요</option>
			<option>운동</option>
			<option>요리</option>
			<option>문화</option>
			<option>예술</option>
			<option>IT</option>
			<option>기타</option>
		</select>
	</div>
	<div class="row">
		<label>강좌 상세내용</label>
		<textarea rows="5" cols="20" name="lecDetail" required class="form-input"></textarea>
	</div>
	<div class="row">
		<label>대여할 장소</label>
		<!-- 1. 장소 리스트에 있는 곳을 고를 경우  -->
		<!-- 2. 직접 장소를 고를 경우(지도 api에서 클릭) -->
		<!-- 3. 온라인 or null -->
<!-- 		<select name="placeIdx" required class="form-input" id="selbox"> -->
<%-- 		<c:forEach var="placeDto" items="${placeList}"> --%>
<%-- 			<option>${placeDto.placeName}</option> --%>
<%-- 		</c:forEach> --%>
<!-- 			<option value="direct">직접입력</option> -->
<!-- 		</select> -->
		<!-- 상단의 select box에서 '직접입력'을 선택하면 나타날 인풋박스 -->
<!-- 		<input type="text" id="selboxDirect" name="lecLocRegion"/> -->
		<input type="number" name="placeIdx" required class="form-input">
		<div id="selboxDirect" style="width:500px;height:400px;"></div>
		
	</div>
	<div class="row">
		<label>수강료</label>
		<input type="number" name="lecPrice" required class="form-input">
	</div>
	<div class="row">
		<label>수강 인원</label>
		<input type="number" name="lecHeadCount" required class="form-input">
	</div>
	<div class="row">
		<label>강의 수</label>
		<input type="number" name="lecContainsCount" required class="form-input">
	</div>
		<div class="row">
		<label class="form-block">강좌 시작 시간</label>
		<input type="date" name="lecStart" required class="form-input form-inline">
	</div>
	<div class="row">
		<label class="form-block">강좌 종료 시간</label>
		<input type="date" name="lecEnd" required class="form-input form-inline">
	</div>
	<div class="row">
		<label>첨부 파일</label>
		<input type="file" name="attach" class="form-btn" multiple>
	</div>
	<div class="row">
		<input type="submit" value="등록" class="form-btn">
	</div>
</div>

</form>