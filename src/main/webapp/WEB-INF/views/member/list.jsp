<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

</script>
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
			회원
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<!-- 소단원 내용 -->
<form  method="post" class="mt-4">
<!--  제목 검색:	<input type="text" name="title">  -->
 <input type="checkbox" name="placeSido" value="제주" class="form-check-input">제주도
  <input type="checkbox" name="placeSido" value="강원" class="form-check-input">강원도
  <input type="checkbox" name="category" value="운동" class="form-check-input">운동
  <input type="checkbox" name="category" value="미술" class="form-check-input">미술
   <input type="checkbox" name="category" value="음악" class="form-check-input">음악


 <input type="text" name="memberId">
 <button type="submit" class="btn btn-danger btn-sm">검색</button>
 
</form>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강의장 목록</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">프로필사진</th>
								<th scope="col" class="text-center align-middle text-nowrap">아이디</th>
								<th scope="col" class="text-center align-middle text-nowrap">이름</th>
								<th scope="col" class="text-center align-middle text-nowrap">주소</th>
								<th scope="col" class="text-center align-middle text-nowrap">등급</th>
								<th scope="col" class="text-center align-middle text-nowrap">포인트</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="MemberListVO" items="${list}">
								<tr class="cursor-pointer">
									<td class="text-center align-middle text-nowrap">${MemberListVO.memberIdx}</td>
									<td class="text-center align-middle text-nowrap"><img src="${pageContext.request.contextPath}/member/file/${MemberListVO.memberProfileIdx}" width="20%"></td>
									<td class="text-center align-middle text-nowrap"><a href="${pageContext.request.contextPath}/member/mypage/${MemberListVO.memberIdx}">${MemberListVO.memberNick}</a></td>
									<td class="text-center align-middle text-nowrap">${MemberListVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">${MemberListVO.memberRegistered}</td>
									<td class="text-center align-middle text-nowrap">${MemberListVO.memberGradeName}</td>
									<td class="text-center align-middle text-nowrap">${MemberListVO.memberPoint}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
			<button type="button"class="col-auto btn btn-sm btn-outline-primary">목록으로</button>
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

<%-- 디자인 적용전
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
		<tr align="center">
		<th width="30%">사진</th>
			<th>번호</th>
			<th >제목</th>
			<th>작성자</th>
			<th>지역</th>
			<th>인원</th>
			<th>제목2</th>
		</tr>
	</thead>


	<tbody align="center">
		<c:forEach var="GatherVO" items="${list}">
			<tr align="center">
			
				<td>
				<img src="${pageContext.request.contextPath}/gather/file/${GatherVO.gatherFileIdx}" width="20%">
				</td>		
				<td>${GatherVO.gatherIdx}</td>
				<td>
				<a href="${pageContext.request.contextPath}/gather/detail/${GatherVO.gatherIdx}">${GatherVO.gatherName }</a>
				</td>
				<td>${GatherVO.memberNick}</td>
				<td>${GatherVO.gatherLocRegion}</td>
				<td>${GatherVO.gatherHeadCount}</td>
				<td>${GatherVO.gatherName}</td>
				<td><input type="hidden" class="fgTitle" value="${GatherVO.gatherName}"></td>
				<td><input type="hidden" class="fgLatitude" value="${GatherVO.gatherLocLatitude}"></td>
			 	<td><input type="hidden" class="fgLongitude" value="${GatherVO.gatherLocLongitude}"></td>
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
--%>