<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
<style type='text/css'>
	#selboxDirect { min-width:200px; min-height:200px; }
	
	/* 파일 드롭존 관련 설정 */
    #fileInputEl { border:1px solid red; }
    #fileDropZone { border:1px solid green; }
    #fileDropZone.dragenter, #fileDropZone.dragover { border: 10px solid blue; }
    
</style>
<script type='text/javascript'>

//첨부파일 저장소 (files 안에 Object형 file 객체들이 들어감)
const fileStageArr = [];

// 첨부파일 저장소에 새 파일을 추가해주는 함수
function addFiles(filesObjArr) {
	fileStageArr = fileStageArr.concat(filesObjArr);
}

// 첨부파일 저장소에서 특정 번째의 파일을 삭제하는 함수
function removeFile(idx) {
	fileStageArr.splice(idx, 1);
}

// 업로드 파일 목록을 새로 갱신해서 보여줌
function refreshFilesStageList(filesList) {
    console.log("파일 목록:\n", filesList);
    fileEl.files = filesList;
    truncateEl(dropZoneEl);
    Array.from(fileEl.files).forEach((oneFile) => {
        console.log(" ㅡ 파일 추가: ", oneFile);
        dropZoneEl.append(
            createEl('div', { class:['d-flex', 'justify-contents-center', 'align-items-center'], child:[
                createEl('span', { text:oneFile.name }),
                createEl('button', { class:['badge', 'rounded-pill', 'bg-danger'], text:'X' })
            ]})
        );
    });
}

// 파일 저장소 정보 내용대로 <input type=file> 태그를 새로 만들어 리턴해줌
function fileStageArr_prepareToSend() {
	const formData = new FormData();
	console.log("생성된 formData:", formData);
	fileStageArr.map((file, i) => {
		console.log(i + "번째 파일: ", file);
		formData.append(`file_{i + 1}`, file);
	});
	console.log("최종 formData:");
	return formData;
}

// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {

    // 엘리먼트 및 환경변수 선언
    console.log("엘리먼트 선언");
    window.fileEl = document.getElementById("fileInputObj");
    window.dropZoneEl = document.getElementById("fileDropZone");
    window.dropZoneClassList = ["dragenter", "dragleave", "dragover", "drop"];

    
    // (input 태그를 쓸 경우 한정) input 태그를 통해 업로드를 할 경우, 변화를 감지하여 통으로 대체
    fileEl.addEventListener("change", (e) => { applyFilesToInput(e) });
    // 드래그한 파일이 드롭존에 진입했을 때
    dropZoneEl.addEventListener("dragenter", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragenter", dropZoneClassList); });
    // 드래그한 파일이 드롭존을 벗어났을 때
    dropZoneEl.addEventListener("dragleave", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragleave", dropZoneClassList); });
    // 드래그한 파일이 드롭존에 머물러 있을 때
    dropZoneEl.addEventListener("dragover", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragover", dropZoneClassList); });
    // 드래그한 파일이 마우스를 뗌으로써 최종 드랍되었을 때
    dropZoneEl.addEventListener("drop", (e) => { e.preventDefault(); onSpecificClasses(dropZoneEl, "drop", dropZoneClassList);
        
    	// 시작 알림
    	console.log("새로운 파일 드래그됨");
        
        // 이벤트 내에서 파일전송 정보 객체를 찾음
        var receivedFilesList = e.dataTransfer && e.dataTransfer.files;
        console.log("드래그로 접수된 파일 정보: ", receivedFilesList);
        
        // 파일 유형 검사.
        // 검사 1) 폴더일 경우 업로드 불가 = 빠꾸
        // ※ 폴더도 객체 1개로 취급되기 때문에 length로 에러 검출하면 안 될 것 같다. 넣어도 작동은 하니 냅둠.
        if(receivedFilesList.length < 1) { alert("폴더는 업로드 불가능합니다."); return; }
        // 검사 2) .type 빈값이다 = 폴더다 = 에러 = 빠꾸
        Array.from(receivedFilesList).forEach((one) => {
            if(one.type.length == 0) { alert("일반 파일 외에는 업로드할 수 없습니다."); return; }
        });
        
        // 검사가 끝났으면, 이걸로 업로드된 파일 정보 배열을 생성
        const filesObjArr = Object.keys(receivedFilesList).map((i) => receivedFilesList[i]);
        console.log("파일 오브젝트 목록 생성:fileObjArr\n", filesObjArr);
        // 파일 정보 배열을 이용해 파일 목록에 추가 처리를 함
        addFiles(filesObjArr);
        // 처리가 끝났으면, 파일 input 태그는 더 이상 이용할 필요 없으니 싹 비움.
        fileInputObj.value = "";
        
        //addFilesToInput(receivedFilesList);
        //refreshFilesStageList(fileEl.files);
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


<form method="post" enctype="multipart/form-data" class="container">
	<div class="row mb-4">
		<label>강좌 이름</label>
		<input type="text" name="lecName" required class="form-input" value="${lecDetailVO.lecName}">
	</div>
	<div class="row mb-4">
		<label>카테고리</label>
		<select name="lecCategoryName" required class="form-input">			
			<option value="">선택하세요</option>
			<option value="운동" ${lecDetailVO.lecCategoryName == '운동' ? selected : ''}>운동</option>
			<option value="요리" ${lecDetailVO.lecCategoryName == '요리' ? selected : ''}>요리</option>
			<option value="문화" ${lecDetailVO.lecCategoryName == '문화' ? selected : ''}>문화</option>
			<option value="예술" ${lecDetailVO.lecCategoryName == '예술' ? selected : ''}>예술</option>
			<option value="IT" ${lecDetailVO.lecCategoryName == 'IT' ? selected : ''}>IT</option>
			<option value="기타" ${lecDetailVO.lecCategoryName == '기타' ? selected : ''}>기타</option>
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
		<input type="number" name="placeIdx" required class="form-input">
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
 		<label>첨부 파일</label>
 		<!-- class="d-none" --> 
 		<input id="fileInputObj" type="file" name="attach" multiple>
 		<!-- 드롭존 겸 파일리스트 -->
 		<div id="fileDropZone">아니면 파일을 여기에 드래그하세요.</div>
 	</div>
	<div class="row mb-4">
		<input type="submit" value="수정" class="form-btn">
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
