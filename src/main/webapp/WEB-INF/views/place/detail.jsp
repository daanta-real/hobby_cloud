<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 강의장 상세 페이지</TITLE>


<script type="text/javascript">

$(function() {
	//지도 생성 준비 코드
	var container = document.querySelector("#map");
	var options = {
		center : new kakao.maps.LatLng($("input[name=placeLocLongitude]").val(), $(
				"input[name=placeLocLatitude]").val()),
		level : 3
	};

	//지도 생성 코드
	var map = new kakao.maps.Map(container, options);

	// 마커가 표시될 위치입니다 
	var markerPosition = new kakao.maps.LatLng($("input[name=placeLocLongitude]")
			.val(), $("input[name=placeLocLatitude]").val());

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		position : markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
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
			${placeVO.placeName} 강의장 상세페이지
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
			<div class="form-group col-12 text-center">
			<!-- 강의장 이미지 -->
				<c:choose>
					<c:when test="${list == null}">
					<img src="https://via.placeholder.com/300x500?text=User" width="50%" class="image">
					</c:when>
					<c:otherwise>
					<c:forEach var="PlaceFileDto" items="${list}"> 
						<img src="${pageContext.request.contextPath}/place/placeFile/${PlaceFileDto.placeFileIdx}" width="50%" 
						class="image image-round image-border">
					</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group col-12">
				<!-- 여기에 장소 표시할 지도 들어갈거임 -->
				<!--상세페이지 지도 -->
				<div class="form-group col-12">
				<input type="hidden" name="placeLocLongitude" value="${placeVO.placeLocLongitude}">
				<input type="hidden" name="placeLocLatitude"  value="${placeVO.placeLocLatitude}">
				<div id="map" style="width:50%;height:350px;"></div>
				</div>
				<div class="form-group col-12">
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">장소 이름</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeName}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 대여자 닉네임</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.memberNick}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">장소 설명</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeDetail}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 사용 카테고리</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.lecCategoryName}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 주소</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeAddress}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 대여 시작일</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeStart}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 대여 마감일</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeEnd}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 최소 금액</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeMin}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 대여 최대 금액</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeMax}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 문의 이메일</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeEmail}" type="text" placeholder="" disabled="">
					</fieldset>					
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 문의 전화</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placePhone}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					<div class="form-group col-12">
					<fieldset disabled="">
					 	 <label class="form-label" for="disabledInput">강의장 등록일</label>
					 	 <input class="form-control" id="disabledInput"  value="${placeVO.placeRegistered}" type="text" placeholder="" disabled="">
					</fieldset>
					</div>
					</div>
					</div>
				<nav class="row p-0 pt-4 d-flex justify-content-end">
					<a href="${root }/place/list" class="col-auto btn btn-sm btn-outline-primary mx-1">목록보기</a>
					<a href="${root }/place/update/${placeVO.placeIdx}" class="col-auto btn btn-sm btn-secondary mx-1">수정</a>
					<a href="${root }/place/delete/${placeVO.placeIdx}" class="col-auto btn btn-sm btn-secondary mx-1">삭제</a>
				</nav>
			</div>
		</div>
		<!-- 소단원 제목 -->		
		<!-- 소단원 내용 -->		
	</SECTION>
	<!-- 페이지 내용 끝. -->	
</ARTICLE>
<!-- 페이지 영역 끝 -->
</DIV>

</SECTION>
<!-- 본문 대구역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>
	
