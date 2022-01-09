<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>



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
const fileImageStorePath = "${root}/lec/lecFile/";
const fileUploadTargetPage = "${root}/lecData/update/";
</SCRIPT>
<!-- 파일 업로드 모듈 자바스크립트 및 CSS 로드 -->
<SCRIPT type='text/javascript' src="${pageContext.request.contextPath}/resources/js/fileUpload.js"></SCRIPT>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fileUpload.css" />



<style type="text/css">
#selboxDirect { min-width:200px; min-height:200px; }
</style>

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
			강좌 수정
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">


<form id="lecFormEl" name="lecForm" method="post" enctype="multipart/form-data" class="container fileUploadForm">
	<input type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}" />
	<div class="row mb-4">
		<label>강좌 이름</label>
		<input type="text" name="lecName" required class="form-input" value="${lecDetailVO.lecName}">
	</div>
	<div class="row mb-4">
		<label>카테고리</label>
		<select name="lecCategoryName" required class="form-input">
			<option value="">선택하세요</option>
			<c:forEach var="val" items="${lecCategoryList}">
				<option value="${val}" ${lecDetailVO.lecCategoryName == val ? 'selected' : ''}>${val}</option>
			</c:forEach>
		</select>
	</div>
	<div class="row mb-4">
		<label>강좌 상세내용</label>
		<textarea rows="5" cols="20" name="lecDetail" required class="form-input">${lecDetailVO.lecDetail}</textarea>
	</div>
	<div class="row mb-4">
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
		<input type="number" name="placeIdx" class="form-input" required value=9999>
		<div class="border border-1 border-primary" id="selboxDirect"></div>
	</div>
	<div class="row mb-4">
		<label>수강료</label>
		<input type="number" name="lecPrice" required class="form-input" value="${lecDetailVO.lecPrice}">
	</div>
	<div class="row mb-4">
		<label>수강 인원</label>
		<input type="number" name="lecHeadCount" required class="form-input" value="${lecDetailVO.lecHeadCount}">
	</div>
	<div class="row mb-4">
		<label>강의 수</label>
		<input type="number" name="lecContainsCount" required class="form-input" value="${lecDetailVO.lecContainsCount}">
	</div>
	<div class="row mb-4">
		<label class="form-block">강좌 시작 시간</label>
		<input type="date" name="lecStart" required class="form-input form-inline" value="${lecDetailVO.lecStart}">
	</div>
	<div class="row mb-4">
		<label class="form-block">강좌 종료 시간</label>
		<input type="date" name="lecEnd" required class="form-input form-inline" value="${lecDetailVO.lecEnd}">
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
		<input type="button" id="fileUploadForm_submitBtn" value="수정 완료" class="form-btn">
	</div>
	<div id="orgFileData" class="d-none">
		<c:forEach items="${fileList}" var="file">
			<div data-server-idx="${file.lecFileIdx}" data-name="${file.lecFileUserName}" data-size="${file.lecFileSize}"></div> 
		</c:forEach>
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
