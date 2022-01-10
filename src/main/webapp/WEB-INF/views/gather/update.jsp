<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<c:set var="login" value="${memberIdx != null }"></c:set>
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

</script>
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

							// 제목
							document.querySelector(".modal-title").innerText = "장소를 고르세요.";
							
							// 내용
							// 표 제목부
							var totalStr
							    = '<table class="table table-striped">'
			                	+ 	'<thead><tr>'
			                    + 		'<th scope="col" class="text-center">순</th>'
			                    + 		'<th scope="col" class="text-center">이름</th>'
			                    +		'<th scope="col" class="text-center">지역</th>'
			                    + 	'</tr></thead>'
			                	+ 	'<tbody class="locTBody">';
							$.each(results, function(i) {
								var jsonStr = results[i];
								console.log(i + "번째 TR: ", jsonStr);
			                	totalStr += '<tr scope="row" data-idx="' + jsonStr.gatherIdx + '"'
									+ 			' data-region="'+jsonStr.gatherLocRegion+'" data-longitude="'+jsonStr.gatherLocLongitude+'"'
									+ 			' data-latitude="' + jsonStr.gatherLocLatitude+'"'
									+ 			' onclick="setLoc(this)">'
									+ 	'<td class="text-center">' + jsonStr.gatherIdx +'</td>'
									+ 	'<td class="text-center">' + jsonStr.gatherName +'</td>'
									+	'<td>' + jsonStr.gatherLocRegion +'</td>'
									+ '</tr>';
							});
							// 표 꼬리부
							totalStr += '</tbody></table>';
							console.log("전체 HTML: ", totalStr);
							
							var listTarget = document.querySelector(".modal-body");
							listTarget.innerHTML = totalStr;
							
						},
						error : function(e) {
						console.log("실패", e);
									}
								});
						});
	});
</script>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />

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
            <table class="table table-striped">
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


<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2 justify-content-center">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			소모임
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>글작성</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5 container justify-content-center">
			<!-- 글내용 -->
			<div class="row justify-content-center">
				
			<div id="map"></div>
				
	<form action="insert" method="post" enctype="multipart/form-data" id="insert-form">

	<div class="mb-3 justify-content-center">
    <label for="" class="form-label">제목</label>
    <input type="text" name="gatherName" class="form-control" value="${GatherVO.gatherName}">
  </div>
			 	
		취미분류:<select name="lecCategoryName" class="selectpicker" data-style="btn-inverse">
    	 <option>운동</option>
    	  <option>미술</option>
      	<option>음악</option>
  		</select>
	<div class="form-group justify-content-center">
      <label for="exampleTextarea" class="form-label mt-4">내용</label>
      <textarea class="form-control" name="gatherDetail" id="exampleTextarea" rows="10" style="resize:none"   value="${GatherVO.gatherDetail}" ></textarea>
    </div>
	
	

  	<div class="mb-3 justify-content-center">
    <label for="" class="form-label">시작시간</label>
    <input type="date"   id="startDate">
    <input type="time"  id="startTime"> 
    <input id="start" type="hidden" name="gatherStart">
  </div>
  
    	<div class="mb-3 justify-content-center">
    <label for="" class="form-label">종료시간</label>
    <input type="date"   id="endDate">
    <input type="time"  id="endTime"> 
    <input id="end" type="hidden" name="gatherEnd">
  </div>
  
  	<div class="mb-3 justify-content-center">
    <label for="" class="form-label">인원</label>
    <input type="number" name="gatherHeadCount" class="form-control" value="${GatherVO.gatherHeadCount}">
  </div>
  
 <button type="button" id="showList"class="btn btn-primary m-3 p-3" 
data-bs-toggle="modal" data-bs-target="#modal">장소 찾기</button> 
  	<div class="mb-3 justify-content-center">
    <label for="" class="form-label">지역</label>
    <input type="text" name="gatherLocRegion" class="form-control" value="${GatherVO.gatherLocRegion}">
  </div>

 <div class="form-group justify-content-center">
      <label for="formFile" class="form-label mt-4"></label>
      <input class="form-control" type="file" id="formFile" name="attach" enctype="multipart/form-data" multiple>
    </div>
	
	  <br>
	<input id="placeIdxHolder" type="hidden" name="placeIdx" value="9999">
	<input	id="placeLatiHolder" type="hidden" name="gatherLocLatitude" value="${GatherVO.gatherLocLatitude}">
	<input id="placeLongHolder" type="hidden" name="gatherLocLongitude"  value="${GatherVO.gatherLocLongitude}">
	
			<div class="form-row text-center">
		 <div class="col-12 pt-3"> 
		  <input type="submit"  id="insert-btn"class="btn btn-primary my-3"> 
        <a href="${pageContext.request.contextPath}/gather/list"
				 class="col-auto btn  btn-secondary mx-1 my-3">취소</a>
    </div>
	</div>
	</form>



			</div>
			
			<!-- 각종 버튼들 -->
		</div>
	</SECTION>
	<!-- 페이지 내용 끝. -->
	
</ARTICLE>
<!-- 페이지 영역 끝 -->



 
<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>