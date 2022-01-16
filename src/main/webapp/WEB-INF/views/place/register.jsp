<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
const fileImageStorePath = "${root}/place/placeFile/";
const fileSubmitAjaxPage = "${root}/placeData/register/";
</SCRIPT>
<!-- 파일 업로드 모듈 자바스크립트 및 CSS 로드 -->
<SCRIPT type='text/javascript' src="${pageContext.request.contextPath}/resources/js/fileUpload.js"></SCRIPT>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fileUpload.css" />

<TITLE>HobbyCloud - 장소 등록</TITLE>

<style type="text/css">
#map { padding-top:56.25%; }
</style>

<script>

///////////////////////////////////// 전역변수부 /////////////////////////////////////

//카카오맵 전역변수 선언. 이렇게 안 하면 onload 이후 관련기능을 쓸 수 없기 때문에 전역변수로 미리 불러와 준다.
let mapContainer, mapOptions, map, geocoder, marker, infowindow;

///////////////////////////////////// 라이브러리부 /////////////////////////////////////
	
	/* 주소 검색 모듈
	 *  .find-address-btn을 누르면 자동으로 주소검색창이 나옴
	 *
	 *  - input[name=placePostcode] 에 우편번호 작성
	 *  - input[name=placeAddress] 에 기본주소 작성
	 *  - input[name=placeDetailAddress] 에 커서 이동
	 */
	 
// 주소 입력 input 태그 안에 주소 value를 채워주는, 우편번호 찾기 기능
function findAddress() {
	new daum.Postcode({
		oncomplete: function (data) {
			console.log("주소가 선택되었습니다.");
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ""; // 주소 변수
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === "R") {
				// 사용자가 도로명 주소를 선택했을 경우
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
					addr = data.roadAddress + " (" + data.bname + ")";
				} else {
					addr = data.roadAddress;
				}
			} else {
				// 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.querySelector("input[name=placePostcode]").value =
				data.zonecode;
			//$("input[name=postcode]").val(data.zonecode);
			document.querySelector("input[name=placeAddress]").value = addr;
			//$("input[name=address]").val(addr);

			//시도
			document.querySelector("input[name=placeSido]").value = data.sido;
			//시군구 (세종시는 sigungu에 null이 들어가서 따로 처리)
			if (
				document.querySelector("input[name=placeSido]").value ==
				"세종특별자치시"
			) {
				document.querySelector("input[name=placeSigungu]").value =
					"세종시";
			} else {
				document.querySelector("input[name=placeSigungu]").value =
					data.sigungu;
			}
			//읍면동
			if (data.bname1 == "") {
				document.querySelector("input[name=placeBname]").value =
					data.bname;
			} else {
				document.querySelector("input[name=placeBname]").value =
					data.bname1;
			}

			//원래 써있던 값지우기
			document.querySelector("input[name=placeDetailAddress]").value =
				null;
			// 커서를 상세주소 필드로 이동한다.
			document.querySelector("input[name=placeDetailAddress]").focus();
			//$("input[name=detailAddress]").focus();
			
			// 지도 렌더링
			renderMap();
			
		},
	}).open();
}

//주소 input창의 내용이 변경되면, 지도 영역에 지도를 표시해주고, 위도/경도/주소 input창에 값을 채워준다.
function renderMap() {
	console.log("지도 input이 변경되었다. 지도 영역을 렌더링하겠습니다");
	//지도 생성 준비 코드
	mapContainer = document.getElementById("map"); // 지도를 표시할 div
	mapOption = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level: 3, // 지도의 확대 레벨
	};
	// 주소-좌표 변환 객체를 생성합니다
	geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
	console.log("geocoder start:", geocoder);
	let searchKeyword = $("#placeAddress").val();
	console.log(searchKeyword);
	geocoder.addressSearch(searchKeyword, function (result, status) {
		// 정상적으로 검색이 완료됐으면
		if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			var message =
				"latlng: new kakao.maps.LatLng(" + result[0].y + ", ";
			message += result[0].x + ")";
			var LocLongitude = result[0].y;
			var LocLatitude = result[0].x;			

			var resultDiv = document.getElementById("clickLatlng");
			resultDiv.innerHTML = message;
			
			$("input[name=placeLocLongitude]").val(LocLongitude);
			$("input[name=placeLocLatitude]").val(LocLatitude);
			
			console.log("result[0].y : " + result[0].y);
			console.log("result[0].x : " + result[0].x);
			console.log("LocLongitude : " + LocLongitude);
			console.log("LocLatitude : " + LocLatitude);
			
			// 지도를 생성합니다
			map = new kakao.maps.Map(mapContainer, mapOption);
			// 결과값으로 받은 위치를 마커로 표시합니다
			marker = new kakao.maps.Marker({
				map: map,
				position: coords,
			});
			// 인포윈도우로 장소에 대한 설명을 표시합니다
			infowindow = new kakao.maps.InfoWindow({
				content:
					'<div style="width:150px;text-align:center;padding:6px 0;">장소</div>',
			});
			infowindow.open(map, marker);
			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
		}
	});
}

// 문서가 로드되면 실행할 코드 영역
$(function () {
	
	// 작성 완료 버튼을 누르면 > 이메일과 폰번호 값을 하나로 합쳐줌
	// 이후에 이벤트 버블링 때문에 폼 객체의 .submit()이 실행된다.
	$(".btnclick").click(function () {
		console.log("작성완료 버튼 누름");
		let placePhone =
			$("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		$('input[name="placePhone"]').val(placePhone);
		console.log(
			"합해진 핸드폰 번호 placePhone : " +
				$("#phone1").val() +
				$("#phone2").val() +
				$("#phone3").val()
		);

		let email = $(".idMail").val() + "@" + $(".inputMail").val();
		$('input[name="placeEmail"]').val(email);
		console.log(
			"이메일 합 : " + $(".idMail").val() + "@" + $(".inputMail").val()
		);
	});

	// 이메일 영역 전체에 대한 change 리스너
	$(".emailBox").change(function () {
		console.log("이메일박스 버튼 누름");
		if ($(".emailBox").val() == "directly") {
			$(".inputMail").attr("readonly", false);
			$(".inputMail").val("");
			$(".inputMail").focus();
		} else {
			$(".inputMail").val($(".emailBox").val());
			$(".inputMail").attr("readonly", true);
		}
	});

	// 주소찾기 버튼 누르면 > 주소 찾는 창이 뜸
	$(".findRegion").click(function () {
		console.log("주소찾기 버튼 누름");
		findAddress();
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
			강의장 등록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
			<form name="placeForm" method="post" class="row container d-flex justify-content-center fileUploadForm">
				<div class="form-group row mb-4">
					<label for="placeForm_placeName" >장소 이름</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<input type="text" name="placeName" required class="form-control">
					</div>
				</div>
				<div class="row mb-4">
					<label for="exampleTextarea">장소 설명</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<textarea id="exampleTextarea" name="placeDetail" required class="form-control" rows="10" style="resize:none">
					</textarea>
					</div>
					</div>
				<div class="row mb-4">
					<label for="placeForm_placeName">카테고리</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
						<select name="lecCategoryName" required class="form-control p-1 border-radius-all-25">
							<option value="" class="">선택하세요</option>
							<option value="운동">운동</option>
							<option value="요리">요리</option>
							<option value="문화">문화</option>
							<option value="예술">예술</option>
							<option value="IT">IT</option>
							<option value="directly">기타</option>														
<%-- 							<option value="">선택하세요</option>
							<c:forEach var="val" items="${lecCategoryList}">
								<option value="${val}">${val}</option>
							</c:forEach> --%>
					</select>
					</div>
				</div>
				<div class="row mb-4">
					<label>강의장 주소</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
			 			<input type="text" name="placePostcode" placeholder="우편번호" readonly id="placePostcode" class="form-control">
				 		&nbsp;&nbsp;
				 		<button type="button" id="kakao_Address" class="btn btn-outline-primary mt-1 findRegion border-radius-all-25" value="주소찾기">
				 		주소 찾기
				 		</button>
				 	</div>
					<label>강의장 주소</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
						<input type="text"  id="placeAddress" name="placeAddress" placeholder="상세 주소" class = "form-control" required readonly>
					</div>
			 		<label>강의장 상세주소</label>
			 		<div class="input-group flex-nowrap grayInputGroup p-0">
						<input type="text" id="placeDetailAddress" name="placeDetailAddress" class="form-control border-radius-all-25" placeholder="상세 주소">
						<input type="hidden" name="address" >
					</div>
							<div id="map" style="width:100%;height:350px;"></div>
							<div style="display:none" id="clickLatlng"></div>
						<input type="hidden" id="clickLocLatitude" name="placeLocLatitude">
						<input type="hidden" id="clickLocLongitude" name="placeLocLongitude">
				</div>
				<div class="row mb-4">
					<label class="form-block">대여 가능 시작일</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<input type="date" name="placeStart" required class="form-control form-inline">
					</div>
				</div>
				<div class="row mb-4">
					<label class="form-block">대여 가능 종료일</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<input type="date" name="placeEnd" required class="form-control form-inline">
					</div>
				</div>
				<div class="row mb-4">
					<label>대여희망최소금액</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<input type="number" name="placeMin" class="form-control" >
					</div>
				</div>
				<div class="row mb-4">
					<label>대여희망최대금액</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
					<input type="number" name="placeMax" class="form-control" >
					</div>
				</div>
		
			    <div class="row mb-4">
			    	<label for="joinForm_placeEmail" class="form-label mb-0">이메일</label>
			    	<div class="input-group flex-nowrap grayInputGroup p-0">
						<input type="text" class="idMail form-control border-radius-all-25" name="email_id"  required>&nbsp;@&nbsp;
						<input type="text" class="inputMail form-control border-radius-all-25" name="email_domain" required readonly>&nbsp;
						<select class="emailBox form-control border-radius-all-25" name="emailBox" required>
							<option>이메일 선택</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="directly">직접입력</option>
						</select>
						<input type="hidden" name="placeEmail" class="mail_input" >
					</div>
				</div>
				
				<div class="row mb-4">
	      			<label for="placeForm_placePhone" class="form-label mb-0">핸드폰 번호</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
	 						<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone form-control border-radius-all-25"> &nbsp;&nbsp;&nbsp;_&nbsp;&nbsp;&nbsp;
							<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone form-control border-radius-all-25">&nbsp;&nbsp;&nbsp;_&nbsp;&nbsp;&nbsp;
							<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone form-control border-radius-all-25">	
							<input type="hidden" name="placePhone" id="phoneNum">
					</div>
				</div>
					
				<input type="hidden" name="placeSido" required placeholder="광역시도">
				<input type="hidden" name="placeSigungu" required placeholder="시군구">
				<input type="hidden" name="placeBname" required placeholder="읍면동">
	
				<div class="row mb-4">
					<label>첨부 파일 ${fileList != null and fileList.size() > 0 ? fileList.size() : ''}</label>
					<div class="input-group flex-nowrap grayInputGroup p-0">
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
				</div>
				<div class="row mb-4">
					<input type="submit" id="fileUploadForm_submitBtn" value="작성 완료" class="btnclick btn btn-danger col-sm-12 col-md-9 col-xl-8 border-radius-all-25 form-control">
				</div>
			</form>
		</div>
		</div>
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 --> 
	
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

</form>