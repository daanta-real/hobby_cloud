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
<TITLE>HobbyCloud - 소모임 수정</TITLE>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
});

</script>
</HEAD>

<!-- 파일 업로드 모듈 사전 설정 -->
<%--
파일 업로드 모듈을 적용하기 위한 준비물
1. 아래 사전 변수 설정에 경로 정확히 입력하기 ('/'기호 조심)
   - fileImageStorePath: 이미지를 불러오기 위한 이미지 호출 경로
   - fileUploadTargetPage: AJAX로 데이터를 전송할 대상 페이지
2. AJAX 컨트롤러측 패러미터 VO에는, 아래 필드가 존재해야 한다.
   - List<MultipartFile> attach: 추가할 파일들 정보가 넘어오는 필드
   - List<String> fileDelTargetList: 삭제대상 file idx 목록 (String으로 되어 있음)
	 (단, 편집이 아니라 신규작성인 경우에는 위의 fileDelTargetList는 만들지 않아도 된다.)
3. HTML FORM의 class에는 fileUploadForm 항목이 있어야 한다.
--%>
<SCRIPT TYPE="text/javascript">
const fileImageStorePath = "${root}/gather/gatherFile/";
const fileSubmitAjaxPage = "${root}/gatherData/update/";
</SCRIPT> 
<!-- 파일 업로드 모듈 자바스크립트 및 CSS 로드 -->
<SCRIPT type='text/javascript' src="${pageContext.request.contextPath}/resources/js/fileUpload.js"></SCRIPT>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fileUpload.css" />

<style type="text/css">
.baddr { width:max-content; }
</style>

<script type='text/javascript'>

//카카오맵 전역변수 선언. 이렇게 안 하면 onload 이후 관련기능을 쓸 수 없기 때문에 전역변수로 미리 불러와 준다.
let container, options, map, geocoder, marker, infowindow;

// 좌표로 행정동 주소 정보를 요청합니다
function searchAddrFromCoords(coords, callback) {
	geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
			callback);
}

// 좌표로 법정동 상세 주소 정보를 요청합니다
function searchDetailAddrFromCoords(coords, callback) {
	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);

}

//지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		var infoDiv = document.getElementById('centerAddr');
	}
}

//TR로부터 지역/위도/경도값을 취해 FORM INPUT 안에 넣어주는 함수
function setLoc(el) {

	// 이벤트 버블링 막기
	stopEvent();

	// 내가 클릭한 TR 태그로부터 값 추출
	const data = {
		idx	  : el.getAttribute("data-idx"),
		region   : el.getAttribute("data-region"),
		longitude: el.getAttribute("data-longitude"),
		latitude : el.getAttribute("data-latitude")
	};

	// 추출된 값을 각 INPUT 태그에 넣어주기
//	 document.querySelector("input[name='loc_idx']"	  ).value = data.idx;
	document.querySelector("input[name='gatherLocRegion']"   ).value = data.region;
	document.querySelector("input[name='gatherLocLatitude']").value = data.longitude;
	document.querySelector("input[name='gatherLocLongitude']" ).value = data.latitude;
	
	// 모달 토글
	modal.toggle();

}


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
		
// 모달 창에 띄울 장소 페이지네이션
var page =1;
var size = 10;
// 모달창 더보기 버튼 클릭시 내용을 더 불러와 보여주는 함수 
function showMore() {
	console.log("더보기 버튼 클릭");
	loadPlace(page,size);
	page++;
}

// loadPlace
function loadPlace(pageValue,sizeValue){
	$.ajax({
		url : "${pageContext.request.contextPath}/gatherData/listPlace", 
		type : "get",
		data:{
			page : pageValue,
			size : sizeValue
		}, 
		dataType : "json",
		success:function(resp){
		
		console.log("성공", resp);
		var results = resp;
		console.log(results);

		// 제목 
		document.querySelector(".modal-title").innerText = "장소를 고르세요.";
		
		// 내용 
		// 표 제목부
		var totalStr = '';
		if(results.length > 0) {
			$.each(results, function(i) {
				var jsonStr = results[i];
				console.log(i + "번째 TR: ", jsonStr);
				totalStr += '<tr scope="row" data-idx="' + jsonStr.placeIdx + '"'
					+ 			' data-region="'+jsonStr.placeAddress+'" data-longitude="'+jsonStr.placeLocLongitude+'"'
					+ 			' data-latitude="' + jsonStr.placeLocLatitude+'"'
					+ 			' onclick="setLoc(this)">'
					+ 	'<td class="text-center">' + jsonStr.placeIdx +'</td>'
					+ 	'<td class="text-center">' + jsonStr.placeName +'</td>'
					+	'<td>' + jsonStr.placeAddress +'</td>'
					+ '</tr>';
			});
		}
		// 표 꼬리부
		console.log("추가될 HTML: ", totalStr);
		document.querySelector(".locTBody").innerHTML += totalStr;
		// 모달 끝으로 스크롤
		$('#modal').animate({ scrollTop: $('#modal .modal-dialog').height() }, 500);
	},
	error : function(e) {
		console.log("실패", e);
		}
	});
}

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
	
	// 지도 객체 생성
	container = document.getElementById("map");
	options = {
		center : new kakao.maps.LatLng(37.5339851357212, 126.897094049199),
		level : 4
	};
	map = new kakao.maps.Map(container, options);

	// 주소 변환 객체 생성
	geocoder = new kakao.maps.services.Geocoder();
	marker = new kakao.maps.Marker(); // 클릭한 위치를 표시할 마커입니다
	infowindow = new kakao.maps.InfoWindow({
		zindex : 1
	}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

	//지도 생성 코드
	$(".search-btn").click( function() {
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(
			$("input[name=keyword]").val(),
			function(result, status) {
				
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {
					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					map.setCenter(coords);
					
				}
				
			}
		);
	});

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
				$("input[name=gatherLocRegion]").val(result[0].address.address_name);
				var address = $("input[name=gatherLocRegion]").val();

				//2. 카카오 장소변환 샘플 코드를 복사 후 일부 수정

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(address, function(result, status) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					$("input[name=gatherLocLongitude]").val(result[0].y);
					$("input[name=gatherLocLatitude]").val(result[0].x);
				});
			}
		});
	});

	//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', function() {
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});

	$("#fileUploadForm_submitBtn").click(function(e){
		//시간설정 잘못 된 것
		e.preventDefault();
		makeTime(); 
		let startTime = new Date($("#start").val());
		let endTime	= new Date($("#end").val());
		let today = new Date();
		if(endTime<startTime||startTime<today)
		{
			e.preventDefault();	 
			alert("시간 설정을 확인해주세요");  
		} else if( $("input[name=gatherDetail]").val()==""||
				$("input[name=gatherName]").val()==""||
				$("input[name=gatherHeadCount]").val()==""||
				$("input[name=gatherLocRegion]").val()=="")
				{
			e.preventDefault();	
			alert("빈칸을 입력해주세요 ");
		} else {
			$("#insert-form").submit();
		}
	});

	// 모달 창 초기화
	function modalInitialize() {
		modalInit({
			head:
				'장소를 선택해 주세요.',
			body:
				'<table class="table table-striped">' 
					+ '<thead>' 
						+ '<tr>'
							+ '<th scope="col" class="text-center">순2</th>'
							+ '<th scope="col" class="text-center">이름2</th>'
							+ '<th scope="col" class="text-center">지역</th>'
						+ '</tr>'
					+ '</thead>'
					+ '<tbody class="locTBody">'
						// ajax로 리스트 목록이 나오는 장소
					+ '</tbody>'
				+ '</table>',
			footer: '<button type="button" id="more-btn" onclick="showMore()">더보기</button>'
		});
	}
	modalInitialize();

	// 모달 버튼 클릭 시 모달 여는 이벤트 발생시키기
	$("#showList").click(function(){
		console.log("showList 클릭");
		modalInitialize();
		loadPlace(page,size);
		page++;
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
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2 justify-content-center">

<!-- 제목 영역 시작 -->
<HEADER class='w-100 mb-1 p-2 px-md-3'>
	<div class='row border-bottom border-secondary border-1'>
		<span class="subject border-bottom border-primary border-5 px-3 fs-1">
		소모임 글 작성
		</span>
	</div>
</HEADER>
<!-- 제목 영역 끝 -->
<!-- 페이지 내용 시작 -->
<SECTION class="w-100 pt-0 fs-6">
	<!-- 소단원 제목 -->
	<!-- 소단원 내용 -->
	<div class="row p-sm-2 mx-1 mb-5 container justify-content-center">
		<!-- 글내용 -->
		<form class="fileUploadForm" method="post" enctype="multipart/form-data" id="insert-form" onsubmit=";">
			<div class="row mb-4">
				<label for="" class="form-label">제목</label>
				<input type="text" name="gatherName" class="form-control" value="${GatherVO.gatherName}">
			</div>
			<div class="row mb-4">
				<label for="" class="form-label">카테고리</label>
				<select name="lecCategoryName" required class="form-input">
					<option value="">선택하세요</option>
					<c:forEach var="val" items="${lecCategoryList}">
						<option value="${val}" ${lecDetailVO.lecCategoryName == val ? 'selected' : ''}>${val}</option>
					</c:forEach>
				</select>
			</div>
			<div class="row mb-4 form-group justify-content-center">
				<label for="exampleTextarea" class="form-label">내용</label>
				<textarea class="form-control" name="gatherDetail" id="exampleTextarea" rows="10" style="resize:none">${GatherVO.gatherDetail}</textarea>
			</div>
			<input type="hidden" name="memberIdx" value="${GatherVO.memberIdx}">
			<div class="row mb-4 justify-content-center">
				<label for="" class="form-label">시작시간</label>
				<input type="date" id="startDate" class="col-12 col-sm-6">
				<input type="time" id="startTime" class="col-12 col-sm-6"> 
				<input id="start" type="hidden" name="gatherStart">
			</div>
			<div class="row mb-4 justify-content-center">
				<label for="" class="form-label">종료시간</label>
				<input type="date" id="endDate" class="col-12 col-sm-6">
				<input type="time" id="endTime" class="col-12 col-sm-6"> 
				<input id="end" type="hidden" name="gatherEnd">
			</div>
			<div class="row mb-4 justify-content-center">
				<label for="" class="form-label">인원</label>
				<input type="number" name="gatherHeadCount" class="form-control" value="${GatherVO.gatherHeadCount}">
			</div>
			<div class="row mb-4 justify-content-center">
				<label for="" class="form-label">지역</label>
				<input type="text" name="gatherLocRegion" class="form-control" value="${GatherVO.gatherLocRegion}">
			</div>
			<div class="row mb-4 justify-content-center">
				<button type="button" id="showList"class="btn btn-primary m-3 p-3" data-bs-toggle="modal" data-bs-target="#modal">지역 검색</button>
			</div>
			<div id="map" class="row rounded w-100 m-auto mb-4 screenForceTo16to9"></div>
			<div class="row mb-4 justify-content-center">
				<label for="" class="form-label">상세장소</label>
				<input type="text" name="keyword" class="form-control" placeholder="지역명을 입력해주세요">
			</div>
			<div class="row mb-4">
				<button type="button" class="btn btn-primary search-btn p-3">상세장소 검색</button>
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
			<!-- 작성완료 및 취소 버튼 -->
			<div class="row mb-4">
				<div class="form-row text-center">
					<div class="col-12 pt-3">
						<button type="button" id="fileUploadForm_submitBtn" class="btn btn-primary">작성완료</button>
						<button type="button" onclick="location.href='${pageContext.request.contextPath}/gather/list';" class="col-auto btn btn-secondary mx-1 my-3">취소</button>
					</div>
				</div>
			</div>
			<input id="placeIdxHolder" type="hidden" name="placeIdx" value="9999">
			<input	id="placeLatiHolder" type="hidden" name="gatherLocLatitude" value="${GatherVO.gatherLocLatitude}">
			<input id="placeLongHolder" type="hidden" name="gatherLocLongitude"  value="${GatherVO.gatherLocLongitude}">
			<div id="orgFileData" class="d-none">
				<c:forEach items="${fileList}" var="file">
					<div data-server-idx="${file.gatherFileIdx}" data-name="${file.gatherFileUserName}" data-size="${file.gatherFileSize}"></div> 
				</c:forEach>
			</div>
		</form>
		<!-- 글내용 종료 -->
	</div>
	<!-- 소단원 내용 종료 -->

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
