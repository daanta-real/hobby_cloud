<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
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
			let latti = Number($(".fgLongitude").eq(i).val());
			let longdi = Number($(".fgLatitude").eq(i).val());
	
		
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
<style>
 .tableImg {
    max-width: 7rem;
    max-height: 7rem;
    width: 100%;
    object-fit: cover;
}

</style>

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
			소모임
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<div id="map" style="width: 800px; height: 300px; border-radius: 20px;"></div>	
					<form  method="post" class="mt-4">

						<label for=searchForm_lecLocRegion class="form-label mb-0 d-block">지역</label>
						<div class="btn-group w-100">
							<input name="gatherLocRegion" type="radio" value="서울" class="btn-check" id="Seoul" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '서울').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Seoul">서울</label>
							<input name="gatherLocRegion" type="radio" value="경기" class="btn-check" id="Gyeonggi" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '경기').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Gyeonggi">경기</label>
			 	 			<input name="gatherLocRegion" type="radio" value="부산" class="btn-check" id="Busan" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '부산').get() ? 'checked' : ''}>
				 			<label class="btn btn-outline-primary" for="Busan">부산</label>
					 		<input name="gatherLocRegion" type="radio" value="인천" class="btn-check" id="Incheon" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '인천').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Incheon">인천</label>
							<input name="gatherLocRegion" type="radio" value="대구" class="btn-check" id="Daegu" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '대구').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Daegu">대구</label>
							<input name="gatherLocRegion" type="radio" value="대전" class="btn-check" id="Daejeon" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '대전').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Daejeon">대전</label>
							<input name="gatherLocRegion" type="radio" value="광주" class="btn-check" id="Gwangju" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '광주').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Gwangju">광주</label>
							<input name="gatherLocRegion" type="radio" value="울산" class="btn-check" id="Ulsan" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '울산').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Ulsan">울산</label>
							<input name="gatherLocRegion" type="radio" value="세종" class="btn-check" id="Sejong" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '세종').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Sejong">세종</label>
							<input name="gatherLocRegion" type="radio" value="강원" class="btn-check" id="Gangwon" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '강원').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Gangwon">강원</label>
							<input name="gatherLocRegion" type="radio" value="제주" class="btn-check" id="Jeju" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '제주').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Jeju">제주</label>
							<input name="gatherLocRegion" type="radio" value="충청북" class="btn-check" id="Chungcheongbuk" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '충북').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Chungcheongbuk">충북</label>
							<input name="gatherLocRegion" type="radio" value="충청남" class="btn-check" id="Chungcheongnam" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '충남').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Chungcheongnam">충남</label>
							<input name="gatherLocRegion" type="radio" value="전라북" class="btn-check" id="Jeollabuk" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '전북').get() ? 'checked' : ''}>
					 		<label class="btn btn-outline-primary" for="Jeollabuk">전북</label>
							<input name="gatherLocRegion" type="radio" value="전라남" class="btn-check" id="Jeollanam" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '전남').get() ? 'checked' : ''}>
					 		<label class="btn btn-outline-primary" for="Jeollanam">전남</label>
							<input name="gatherLocRegion" type="radio" value="경상북" class="btn-check" id="Gyeongsangbuk" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '경북').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Gyeongsangbuk">경북</label>
							<input name="gatherLocRegion" type="radio" value="경상남" class="btn-check" id="Gyeongsangnam" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '경남').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="Gyeongsangnam">경남</label>
						</div>
						<div class="form-group mb-4 col-6">
						<label for=searchForm_lecCategoryName class="form-label mb-0 d-block">카테고리</label>
							<div class="btn-group w-100">
								<c:forEach var="lecCategory" items="${lecCategoryList}">
									<input name="gatherCategoryName" type="checkbox" value="${lecCategory}" class="btn-check" id="${lecCategory}" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '${lecCategory}').get() ? 'checked' : ''}>
									${paramValues.paidStatusList.stream().anyMatch(v->v == '${lecCategory}').get()}
									<label class="btn btn-outline-primary" for="${lecCategory}">${lecCategory}</label>
								</c:forEach>
							</div>
					</div>
			<div class="form-group mb-4 col-md-6 col-lg-4">
				<label for="searchForm_memberIdx" class="form-label mb-0">회원 번호</label>
				<input name="gatherName" id="searchForm_memberIdx" type="text" class="form-control" placeholder="제목을 입력하세요" >
				<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
			</div>
			<button type="submit" class="btn btn-danger btn-sm">검색</button>

 			</form>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>소모임 목록</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">사진</th>
								<th scope="col" class="text-center align-middle text-nowrap">제목</th>
								<th scope="col" class="text-center align-middle text-nowrap">작성자</th>
								<th scope="col" class="text-center align-middle text-nowrap">카테고리</th>
								<th scope="col" class="text-center align-middle text-nowrap">지역</th>
								<th scope="col" class="text-center align-middle text-nowrap">인원수</th>
							</tr>
						</thead>  
						<tbody>
						
							<c:forEach var="GatherVO" items="${list}"> 
								<tr class="cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/gather/detail/${GatherVO.gatherIdx}'">
									<td class="text-center align-middle text-nowrap">${GatherVO.gatherIdx}</td>
									<td class="text-center align-middle text-nowrap tableImg"><img src="${pageContext.request.contextPath}/gather/file/${GatherVO.gatherFileIdx}" width="20%"></td>
									<td class="text-center align-middle text-nowrap">${GatherVO.gatherName}</td>
									<td class="text-center align-middle text-nowrap">${GatherVO.memberNick}</td> 
									<td class="text-center align-middle text-nowrap">${GatherVO.lecCategoryName}</td> 
									<td class="text-center align-middle text-nowrap">${GatherVO.gatherLocRegion}</td>
									<td class="text-center align-middle text-nowrap">${GatherVO.gatherHeadCount}</td>
									<input type="hidden" class="fgTitle" value="${GatherVO.gatherName}">
									<input type="hidden" class="fgLatitude" value="${GatherVO.gatherLocLatitude}">
			 					<input type="hidden" class="fgLongitude" value="${GatherVO.gatherLocLongitude}">
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
			<a href="${pageContext.request.contextPath}/gather/list" type="button" class="col-auto btn btn-sm btn-outline-primary">목록으로</a>
  <ul class="col-auto pagination pagination-sm m-0">
    <c:if test="${pageMaker.prev}">
    	<li class="page-item disabled"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"
    	> ◁ </a></li>
    </c:if> 

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li class="page-item ${param.page == idx ? 'active' : ''}"><a  class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">&raquo;</a></li>
    </c:if> 
  </ul>
  <a class="col-auto btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/gather/insert">글쓰기</a>
</nav>
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

