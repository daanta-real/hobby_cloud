<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />


<!-- 파일 업로드 모듈 사전 설정 -->
<%--
파일 업로드 모듈을 적용하기 위한 준비물
1. 아래 사전 변수 설정에 경로 정확히 입력하기 ('/'기호 조심)
   - fileImageStorePath: 이미지를 불러오기 위한 이미지 호출 경로
   - fileUploadTargetPage: AJAX로 데이터를 전송할 대상 페이지
2. AJAX 컨트롤러측 패러미터 VO에는, 아래 필드가 존재해야 한다.
   - List<MultipartFile> attach: 추가할 파일들 정보가 넘어오는 필드
   - List<String> fileDelTargetList: 삭제대상 file idx 목록 (String으로 되어 있음)
     (단, 편집이 아니라 신규작성인 경우에는 fileDelTargetList를 만들지 않아도 된다.)
3. HTML FORM의 class에는 fileUploadForm 항목이 있어야 한다.
--%>
<SCRIPT TYPE="text/javascript">
const fileImageStorePath = "${root}/lec/lecFile/";
const fileSubmitAjaxPage = "${root}/lecData/register/";
</SCRIPT>
<!-- 파일 업로드 모듈 자바스크립트 및 CSS 로드 -->
<SCRIPT type='text/javascript' src="${pageContext.request.contextPath}/resources/js/fileUpload.js"></SCRIPT>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fileUpload.css" />

<TITLE>HobbyCloud - 강좌 등록</TITLE>

<style type="text/css">
#map { padding-top:56.25%; }
</style>

<!-- 카카오지도 관련 처리부 -->
<script type='text/javascript'>

///////////////////////////////////// 전역변수부 /////////////////////////////////////

// 카카오맵 전역변수 선언. 이렇게 안 하면 onload 이후 관련기능을 쓸 수 없기 때문에 전역변수로 미리 불러와 준다.
let container, options, map, geocoder, marker, infowindow;

///////////////////////////////////// 라이브러리부 /////////////////////////////////////

// 좌표로 행정동 주소 정보를 요청합니다
function searchAddrFromCoords(coords, callback) {
	geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
}

// 좌표로 법정동 상세 주소 정보를 요청합니다
function searchDetailAddrFromCoords(coords, callback) {
	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측 상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		var infoDiv = document.getElementById("centerAddr");
	}
}

// TR로부터 지역/위도/경도값을 취해 FORM INPUT 안에 넣어주는 함수
function setLoc(el) {

	// 이벤트 버블링 막기
	stopEvent();
  
	// 내가 클릭한 TR 태그로부터 값 추출
	const data = {
		idx: el.getAttribute("data-idx"),
		region: el.getAttribute("data-region"),
		longitude: el.getAttribute("data-longitude"),
		latitude: el.getAttribute("data-latitude"),
	};
  
	// 추출된 값을 각 INPUT 태그에 넣어주기
	//	 document.querySelector("input[name='loc_idx']"	  ).value = data.idx;
	document.querySelector("input[name='lecLocRegion']").value = data.region;
	document.querySelector("input[name='lecLocLongitude']").value =
		data.longitude;
	document.querySelector("input[name='lecLocLatitude']").value = data.latitude;
  
	// 모달 토글
	modal.toggle();
  
}

// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
	
	
	
	//////////////////////////////////// 일반 ////////////////////////////////
	
	// 대여할 장소 방식 DIV에서 장소 방식을 선택하면, 해당 장소 방식의 DIV만 디스플레이시킨다. 
	document.querySelector("form[name='lecForm'] div[data-toggles='placeType']").addEventListener("change", () => {
		const type = document.forms['lecForm'].placeType.value;
		document.querySelectorAll("form[name='lecForm'] div.layerPlaceDIVs").forEach((el) => {
			if(el.getAttribute("data-layerType") === type) {
				el.classList.add("d-flex");
				el.classList.add("mb-4");
				el.classList.remove("d-none");
				if(el.getAttribute("data-layerType") === "map") {
					map.relayout();
				}
			} else {
				el.classList.add("d-none");
				el.classList.remove("mb-4");
				el.classList.remove("d-flex");
			}
		})
	})
	
	
	
	////////////////////////////////////// 이 밑으로는 모두 카카오지도 관련이다. ///////////////////////



	///////////////////////////////////// 생성자부 /////////////////////////////////////
	
	// 카카오지도 객체 준비
	// 1-1) 지도를 표시할 HTML 엘리먼트
	container = document.querySelector("#map");
	// 1-2) 지도 생성 옵션 객체
	options = {
		center: new kakao.maps.LatLng(37.5339851357212, 126.897094049199),
		level: 4,
	};
	// 1-3) 지도 클래스
	map = new kakao.maps.Map(container, options);
	// 1-4) 주소 ↔ 좌표 변환 객체
	geocoder = new kakao.maps.services.Geocoder();
	// 1-5) 클릭한 위치를 표시할 마커(핀) 객체
	marker = new kakao.maps.Marker();
	// 1-6) 클릭한 위치에 대한 주소를 표시할 인포윈도우(말풍선) 객체
	infowindow = new kakao.maps.InfoWindow({
		zindex: 1,
	});
	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
	searchAddrFromCoords(map.getCenter(), displayCenterInfo);



	///////////////////////////////////// 이벤트부 /////////////////////////////////////

	// search-btn 클래스의 HTML 엘리먼트를 누르면,
	// 지도 중심을 해당 클릭위치로 이동시켜줍니다.
	$(".search-btn").click(function () {
		// 주소로 좌표를 검색한 후, 
		geocoder.addressSearch(
			$("input[name=keyword]").val(),
			function (result, status) {
				// 정상적으로 검색이 완료됐으면
				if (status === kakao.maps.services.Status.OK) {
					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					map.setCenter(coords);
				}
			}
		);
	});

	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, "click", function (mouseEvent) {
		searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var detailAddr = !!result[0].road_address
					? "<div>도로명주소 : " + result[0].road_address.address_name + "</div>"
					: "";
				detailAddr += "<div>지번 주소 : " + result[0].address.address_name + "</div>";
				var content =
					'<div class="bAddr">'
					+ '<span class="title">법정동 주소정보</span>'
					+ detailAddr
					+ "</div>";
	  
			// 마커를 클릭한 위치에 표시합니다
			marker.setPosition(mouseEvent.latLng);
			marker.setMap(map);
	  
			// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			infowindow.setContent(content);
			infowindow.open(map, marker);
			$("input[name=lecLocRegion]").val(result[0].address.address_name);
			var address = $("input[name=lecLocRegion]").val();
	  
			// 2. 카카오 장소변환 샘플 코드를 복사 후 일부 수정
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(address, function (result, status) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				$("input[name=lecLocLatitude]").val(result[0].y);
				$("input[name=lecLocLongitude]").val(result[0].x);
			});
		  }
		});
	});

	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, "idle", function () {
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});
	

	$("#showList").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/gatherData/gatherList",
			type : "get",
			dataType : "json",
			success:function(resp){
				
				var results = resp;
				console.log("성공");
				console.log(resp);
				console.log(results);
				
				var totalStr = "";
				$.each(results, function(i) {
					var jsonStr = results[i];
					console.log(i + "번째 TR: ", jsonStr);
					totalStr += '<tr scope="row" data-idx="' + jsonStr.lecIdx + '"'
						+ ' data-region="'+jsonStr.lecLocRegion+'" data-longitude="'+jsonStr.lecLocLongitude+'"'
						+ ' data-latitude="' + jsonStr.lecLocLatitude+'"'
						+ ' onclick="setLoc(this)">'
						+ '<td class="text-center">' + jsonStr.lecIdx +'</td>'
						+ '<td class="text-center">' + jsonStr.lecName +'</td>'
						+ '<td>' + jsonStr.lecLocRegion +'</td></tr>';
				});
				console.log("전체 HTML: ", totalStr);
				
				var listTarget = document.querySelector(".locTBody");
				console.log("내용을 반영할 타겟 엘리먼트: ", listTarget);
				listTarget.innerHTML = totalStr;
				
			},
			
			error : function(e) {
				console.log("실패", e);
			}
			
		});
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
	// 장소 만들어지면 value값 대체해야함
    // 추출된 값을 각 INPUT 태그에 넣어주기
//     document.querySelector("input[name='loc_idx']"      ).value = data.idx;
    document.querySelector("input[name='lecLocRegion']"   ).value = data.region;
    document.querySelector("input[name='lecLocLongitude']").value = data.longitude;
    document.querySelector("input[name='lecLocLatitude']" ).value = data.latitude;
    
    // 모달 토글
    modal.toggle();

}

</script>


<script>
	$(function() {
		$("#showList").click(function() {
			$.ajax({
			url : "${pageContext.request.contextPath}/lecData/lecList",
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
					totalStr += '<tr scope="row" data-idx="' + jsonStr.lecIdx + '"'
						+ ' data-region="'+jsonStr.lecLocRegion+'" data-longitude="'+jsonStr.lecLocLongitude+'"'
						+ ' data-latitude="' + jsonStr.lecLocLatitude+'"'
						+ ' onclick="setLoc(this)">'
						+ '<td class="text-center">' + jsonStr.lecIdx +'</td>'
						+ '<td class="text-center">' + jsonStr.lecName +'</td>'
						+ '<td>' + jsonStr.lecLocRegion +'</td></tr>';
				});
				console.log("전체 HTML: ", totalStr);
				
				var listTarget = document.querySelector(".locTBody");
				console.log("내용을 반영할 타겟 엘리먼트: ", listTarget);
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
			강좌 등록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form name="lecForm" method="post" class="row container d-flex justify-content-center fileUploadForm">
					<div class="form-group row mb-4">
						<label>강좌 이름</label>
						<input type="text" name="lecName" required class="form-input p-1 border-radius-all-25"/>
					</div>
					<div class="row mb-4">
						<label>카테고리</label>
						<select name="lecCategoryName" required class="form-input p-1 border-radius-all-25">
							<option value="">선택하세요</option>
							<c:forEach var="val" items="${lecCategoryList}">
								<option value="${val}">${val}</option>
							</c:forEach>
						</select>
					</div>
					<div class="row mb-4">
						<label>강좌 상세내용</label>
						<textarea rows="5" cols="20" name="lecDetail" required class="form-input p-1 border-radius-all-25">${lecDetailVO.lecDetail}</textarea>
					</div>
					<%--
					1. 장소 리스트에 있는 곳을 고를 경우
					2. 직접 장소를 고를 경우(지도 api에서 클릭)
					3. 온라인 or null
						<select name="placeIdx" required class="form-input" id="selbox">
							<c:forEach var="placeDto" items="${placeList}">
								<option>${placeDto.placeName}</option>
							</c:forEach>
							<option value="direct">직접입력</option>
						</select>
						상단의 select box에서 '직접입력'을 선택하면 나타날 인풋박스
							<input type="text" id="selboxDirect" name="lecLocRegion"/>
					--%>
					<div class="row form-group">
						<label for="placeType">대여할 장소 선택</label>
						<div class="input-group p-0">
							<div class="btn-group" data-toggles="placeType">
								<input type="radio" name="placeType" class="btn-check" id="radioPlaceList" value="list">
								<label class="btn btn-primary" for="radioPlaceList">장소 목록에서 선택</label>
								<input type="radio" name="placeType" class="btn-check" id="radioPlaceMap" value="map">
								<label class="btn btn-primary" for="radioPlaceMap">지도에서 선택</label>
								<input type="radio" name="placeType" class="btn-check" id="radioPlaceOnline" value="online">
								<label class="btn btn-primary" for="radioPlaceOnline">온라인</label>
							</div>
							<input type="hidden" name="placeType" />
						</div>
					</div>
					<div class="row p-2 bg-warning rounded layerPlaceDIVs d-none" data-layerType="list">
						<label>장소 목록</label>
						<input type="text" name="lecName" required class="form-input" />
					</div>
					
					<div class="row p-2 bg-warning rounded container layerPlaceDIVs d-none" data-layerType="map">
						<label for="searchForm_memberIdx" class="form-label mb-0">지도 검색</label>
						<div id="map" class="md-3"></div>
						<label>지역<input type="text" name="lecLocRegion"></label>
						<input id="placeIdxHolder" type="hidden" name="placeIdx">
						<label>위도<input id="placeLatiHolder" type="text" name="lecLocLatitude"></label>
						<label>경도<input id="placeLongHolder" type="text" name="lecLocLongitude"></label>
					</div>
					
					
					
					<div class="row mt-4 mb-4">
						<label>수강료</label>
						<div class="input-group flex-nowrap grayInputGroup p-0">
							<div class="input-group-text">&#8361;</div>
							<input type="number" name="lecPrice" required class="form-control">
						</div>
					</div>
					<div class="row mb-4">
						<label>수강 인원</label>
						<div class="input-group flex-nowrap grayInputGroup p-0">
							<div class="input-group-text">최대</div>
							<input type="number" name="lecHeadCount" required class="form-control">
							<div class="input-group-text">명</div>
						</div>
					</div>
					<div class="row mb-4">
						<label>강의 수</label>
						<input type="number" name="lecContainsCount" required class="form-input p-1 border-radius-all-25">
					</div>
					<div class="row mb-4">
						<label class="form-block">강좌 시작 시간</label>
						<input type="date" name="lecStart" class="form-input form-inline p-1 border-radius-all-25">
					</div>
					<div class="row mb-4">
						<label class="form-block">강좌 종료 시간</label>
						<input type="date" name="lecEnd" class="form-input form-inline p-1 border-radius-all-25">
					</div>
					<div class="row mb-4">
						<label>첨부 파일 ${fileList != null and fileList.size() > 0 ? fileList.size() : ''}</label>
						<!-- 드롭존 겸 파일리스트 -->
						<div id="fileDropZoneBox" class="w-100 p-0">
							<c:choose>
								<c:when test="${fileList != null and fileList.size() > 0}">
									<div id="fileDropZone" class="
											w-100 fs-4 rounded text-dark
											border-1 border-secondary p-2">
									</div>
								</c:when>
								<c:otherwise>
									<div id="fileDropZone" class="
											w-100 fs-4 border-5 border-light rounded p-5
											justify-content-center align-items-center
											text-dark bg-secondary bg-gradient">
											<div id="fileDropZoneDefaultText" class="text-center">파일을 여기에 드래그하여 첨부해 보세요.</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row mb-4">
						<input type="submit" id="fileUploadForm_submitBtn" value="작성 완료" class="form-btn p-1 border-radius-all-25">
					</div>
				</form>
			</div>
		</div>

	</SECTION>
	<!-- 페이지 내용 끝. -->
	
</ARTICLE>
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>

