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
<style type='text/css'>
/*

			
${SERVER_ROOT}
${SERVER_PORT}
${CONTEXT_NAME}
*/

	/* 기본 애니메이션 정의 */
	@keyframes slideInFromLeft {
		0% { transform:scale(0.98); }
		50% { transform:scale(1.03); }
		100% { transform:scale(1); }
	}
	

	#selboxDirect { min-width:200px; min-height:200px; }
    
	/* 파일 드롭존 관련 설정 */
	#fileDropZoneBox { display:flex; justify-content:center; align-items:center; }
	#fileDropZone { border-style:double; display:grid; justify-content:center; grid-template-columns: repeat(auto-fit, minmax(7.5rem, max-content)); }

    /* 파일 첨부 시 미리보기 이미지 표시 관련 설정 */
    .fileBox { width:7.5rem; height:9.5rem; animation: 0.2s ease-out 0s 1 slideInFromLeft; }
    .fileBox.deleted { cursor:pointer; }
    .fileBox.deleted:after {
	    content: "삭 제";
	    position: absolute; left:1.5%; top:1.5%; width: 97%; height: 97%;
	    display: flex; justify-content: center; align-items: center;
	    color: rgba(255,255,255,0.8); background: rgba(0,0,0,0.3); border-radius: 1rem;
	    cursor: pointer;
	}
	.fileBox.deleted > .fileRemoveBtn { display:none; }
	.fileTxt {
		width:7rem; max-width:7rem; height:2rem; max-height:2rem;
		font-size:0.6rem; text-align:center; word-break:break-all; text-overflow:ellipsis;
	}
    .fileImg { width:7rem; height:7rem; object-fit:contain; }
    .fileRemoveBtn { right:-1rem; top:-1rem; }
    
    /* 수정 완료 버튼 */
    #placeForm_submitBtn { cursor:pointer; }
    
</style>
<script type='text/javascript'>



///////////////////////////////////// 엘리먼트 생성/조작/데이터조회 관련 라이브러리 /////////////////////////////////////

// 드롭존 내용을 초기화해주는 함수
function initializeDropZone() {
	
	// "파일 드래그하세요" 안내문 제거
	document.getElementById("fileDropZone").removeChild(document.getElementById("fileDropZoneDefaultText"));
	
	// 미리 걸어논 속성들 제거
	dropZoneEl.classList.remove(
		"p-5", "border-5", "border-light", // 보더 속성
		"bg-secondary", "bg-gradient", // 흰 글씨와 그래디언트 배경 제거
		"align-items-center" // 텍스트를 중앙에 표시하는 속성
	);

	// 새 속성 추가
	dropZoneEl.classList.add("border-1", "border-secondary", "p-2");

}

// 첨부파일 이미지의 텍스트 설명 엘리먼트 생성 및 회신
function makeFileTxtEl(name, size) {
	return createEl("small", { 
		class:['fileTxt'],
		child: [
			createEl("span", { text: name }),
			createEl("span", { text: " " }),
			createEl("span", { text: "(" + byteString(size, 3) + ")" })
		]
	});
}

// 첨부파일 이미지의 삭제 버튼 엘리먼트 생성 및 회신
function makeFileDeleteBtnEl() {
	const el = createEl("i", {
		class:[
			'fileRemoveBtn', 'text-danger', 'fs-3',
			'position-absolute', 'xi-close-circle', 'top-0', 'end-0',
			'cursor-pointer'
		]
	});
	return el;
}

// 첨부파일 이미지의 삭제 버튼 엘리먼트 생성 및 회신
function makeFileBoxEl(type, name, size, serverIdx) {
	let result = { boxEl:null, imgEl:null };
	result.imgEl = createEl('img', {class:['fileImg']});
	result.btnEl = makeFileDeleteBtnEl();
	result.boxEl = createEl("div", {
		class:[
			'fileBox',
			'd-flex', 'flex-column',
			'justify-content-center', 'align-items-center', 'position-relative'
		],
		attr:{
			'data-type': type, // 기존 파일인 경우 old, 새 파일인 경우 new
			'data-seq': ++fileTempSeq, // 본 페이지 내에서만 쓰는 파일의 고유 일련번호
			'data-server-idx': serverIdx || ""
		},
		child:[
			result.imgEl, // 파일 이미지
			makeFileTxtEl(name, size), // 파일 설명
			result.btnEl // 이미지 삭제 버튼
		]
	});
	return result;
}

// 파일 객체를 넘기면, FileReader가 이미지 내용물을 로드해 대상 이미지 태그에 반영함으로써
// 이미지를 로드시켜 준다.
// 패러미터: 대상 파일객체, 대상 이미지 태그
function renderImageFromFile(file, targetEl) {
	console.log(file.name);
	const reader = new FileReader();
	reader.readAsDataURL(file);
	reader.addEventListener('load', (e) => {
		targetEl.src = e.target.result;
	});
}

// data 태그로부터 정보를 읽어와 기존 파일의 정보 배열인 orgFilesArr에 추가해주는 함수
function readyOrgFiles() {
	const orgFileList = document.querySelectorAll("#orgFileData > div");
	orgFileList.forEach((one) => {
		let newFile = {
			idx: one.getAttribute("data-server-idx"),
			name: one.getAttribute("data-name"),
			size: one.getAttribute("data-size")
		};
		orgFilesArr.push(newFile);
	});
}



///////////////////////////////////// 첨부파일의 추가/삭제 처리 /////////////////////////////////////

// 기존 글의 첨부파일을 첨부파일 뷰에 추가해 주는 함수
function loadOrgFiles() {
	//orgFilesArr
	for(var i in orgFilesArr) {
		const oneFile = orgFilesArr[i]; // 각 파일 정보 획득 (idx, 이름, 크기)
		const boxObj = makeFileBoxEl('old', oneFile.name, oneFile.size, oneFile.idx); // 첨부파일 이미지 박스 오브젝트 생성
		dropZoneEl.append(boxObj.boxEl); // 이미지 박스 엘리먼트를 첨부파일 뷰어에 추가
		boxObj.imgEl.src = "${pageContext.request.contextPath}/place/placeFile/" + oneFile.idx;
		boxObj.btnEl.addEventListener("click", removeFileOrg);
	}
}

// 새 파일이 접수되면, 첨부파일 뷰에도 추가하고 저장소에도 추가해 주는 함수
function addFiles(filesObjArr) {
	
	// 입수된 모든 파일 객체에 대해서 실시
	for(var i in filesObjArr) {
		const oneFile = filesObjArr[i]; // 각 파일 객체 획득
		const boxObj = makeFileBoxEl('new', oneFile.name, oneFile.size); // 첨부파일 이미지 박스 오브젝트 생성
		dropZoneEl.append(boxObj.boxEl); // 이미지 박스 엘리먼트를 첨부파일 뷰어에 추가
		boxObj.btnEl.addEventListener("click", removeFileNew);

		// 이미지 여부에 따른 미리보기 로드 처리
		if(oneFile.type.substr(0, 5) === "image") {
			// 이미지 로드 예약 걸기
			renderImageFromFile(oneFile, boxObj.imgEl);
		} else {
			console.log("이미지 타입이 아니네요");
			// 파일 아이콘 보여주기
			boxObj.imgEl.src="${pageContext.request.contextPath}/resources/img/normalFile.png";
		}
		
		// 파일 저장소 변수에 새 파일 정보를 추가
		fileStageArr[fileTempSeq] = oneFile;
	}
	

}

// 파일 첨부현황에서 특정 기존파일을 삭제 예약하는 함수
function removeFileOrg(e) {
	// 이벤트 버블링 방지
	e.preventDefault(); e.stopPropagation();
	// 이벤트대상 엘리먼트 획득
	const target = e.target.parentNode;
	// 첨부목록 뷰에 있는 파일은 음영 처리한다.
	target.classList.add("deleted");
	// 삭제대상 placeFileIdx 획득
	const serverIdx = target.getAttribute("data-server-idx");
	// fileDeleteTargets 배열에는 DB의 idx를 추가한다.
	fileDeleteTargets.push(serverIdx);
	// 이벤트대상 엘리먼트에, 클릭 시 복구시키는 함수를 실행시키도록 리스너를 걸어놓는다.
	target.removeEventListener("click", removeFileOrg);
	target.addEventListener("click", restoreFileOrg);
}

// 파일 첨부현황에 삭제예약된 특정 기존파일을 다시 복구시키는 함수 
function restoreFileOrg(e) {
	// 이벤트 버블링 방지
	e.preventDefault(); e.stopPropagation();
	// 이벤트대상 객체 획득
	const target = e.target;
	// 첨부목록 뷰에 있는 파일의 음영 처리를 원복시킨다.
	target.classList.remove("deleted");
	// 삭제예약된 placeFileIdx 획득
	const serverIdx = target.getAttribute("data-server-idx");
	// fileDeleteTargets 배열에서 placeFileIdx를 뺀다.
	fileDeleteTargets = arr_remove_val(fileDeleteTargets, serverIdx);
	// 이벤트대상 엘리먼트에, 클릭 시 복구시키는 함수를 제거한다.
	target.removeEventListener("click", restoreFileOrg);
}

//파일 첨부현황에서 특정 신규파일을 삭제 예약하는 함수
function removeFileNew(e) {
	// 이벤트 버블링 방지
	e.preventDefault(); e.stopPropagation();
	// 이벤트대상 엘리먼트 획득
	const target = e.target.parentNode;
	// 삭제대상 일련번호인 fileTempSeq 획득
	const fileTempSeq = target.getAttribute("data-seq");
	// 해당하는 fileTempSeq 일련번호 위치의 파일 데이터를 fileStageArr로부터 제거한다.
	console.log(fileTempSeq + "번 원소 제거", fileStageArr);
	delete fileStageArr[fileTempSeq]; 
	console.log(fileTempSeq + "번 원소 제거 결과:", fileStageArr);
	// 첨부파일 뷰에서도 엘리먼트를 정리한다.
	document.getElementById("fileDropZone").removeChild(
		document.querySelector("#fileDropZone > div.fileBox[data-seq='" + fileTempSeq + "']")
	);
}



///////////////////////////////////// FORM의 최종 제출 처리 /////////////////////////////////////

// 파일 저장소 정보 내용대로 <input type=file> 태그를 새로 만들어 리턴해줌
function sendForm() {
	
	// formData 객체 생성: 기존 Form의 입력값을 전부 품은 객체 
	let formData = new FormData(document.querySelector("#placeFormEl"));
	
	// formData에 파일 정보 모두 추가
	for(var i in fileStageArr) formData.append("attach", fileStageArr[i]);
	
	// formData에 삭제 대상 파일 정보 추가
	fileDeleteTargets.map((idx) => { formData.append("placeFileDelTargetList", idx)});
	
	// 완성된 전체 formData 확인
	console.log("완성된 formData:");
	for (var p of formData) console.log(p);

	// AXIOS를 이용하여 FORM DATA 제출
	axios.post("http://localhost:8080/hobbycloud/placeData/update", formData, {
		headers: { "Content-type": "multipart/form-data" }
	}).then((response) => {
		location.href = "${root}/place/detail/${placeVO.placeIdx}";
	}).catch((response) => {
		console.log("에러");
		console.log(response);
	});

}



///////////////////////////////////// 실행부 /////////////////////////////////////

// 변수설정
let fileStageArr = {}; // 새 첨부파일 정보저장 오브젝트 (files 안에 Object형 file 객체들이 들어감)
let fileTempSeq = -1; // 첨부파일 뷰에서 표시될 파일 고유 순번 (기존/신규 안 가림)
let orgFilesArr = []; // 기존 파일의 정보를 담은 배열
let fileDeleteTargets = []; // 삭제할 대상의 파일 정보를 담은 배열


// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {

    // 엘리먼트 및 환경변수 선언
    console.log("엘리먼트 선언");
    window.dropZoneEl = document.getElementById("fileDropZone");
    window.dropZoneClassList = ["dragenter", "dragleave", "dragover", "drop"];

    // 드래그한 파일이 드롭존에 진입했을 때
    dropZoneEl.addEventListener("dragenter", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragenter", dropZoneClassList); });
    // 드래그한 파일이 드롭존을 벗어났을 때
    dropZoneEl.addEventListener("dragleave", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragleave", dropZoneClassList); });
    // 드래그한 파일이 드롭존에 머물러 있을 때
    dropZoneEl.addEventListener("dragover", (e) => { e.stopPropagation(); e.preventDefault(); onSpecificClasses(dropZoneEl, "dragover", dropZoneClassList); });
    // 드래그한 파일이 마우스를 뗌으로써 최종 드랍되었을 때
    dropZoneEl.addEventListener("drop", (e) => { e.preventDefault(); onSpecificClasses(dropZoneEl, "drop", dropZoneClassList);
    
    	// 첫 파일 올릴 때 드롭존 초기화함.
    	if(orgFilesArr.length == 0 && Object.keys(fileStageArr).length === 0) initializeDropZone();
    	
        // 접수된 파일(들) 전송 정보 객체를 이벤트 객체에서 캐냄
        var receivedFilesList = e.dataTransfer && e.dataTransfer.files;
        
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
        
    });
    
    // 기존 파일의 이미지 모두 로드
    readyOrgFiles();
    loadOrgFiles();
    
    // 수정 완료 버튼 클릭 시 이벤트 실행
    document.getElementById("placeForm_submitBtn").addEventListener("click", sendForm);

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
			강의장 수정
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">


<form id="placeFormEl" name="placeForm" method="post" enctype="multipart/form-data" class="container">
	<input type="hidden" name="placeIdx" value="${placeVO.placeIdx}" />
	<div class="row mb-4">
		<label>장소 이름</label>
		<input type="text" name="placeName" required class="form-input" value="${placeVO.placeName}">
	</div>
	<div class="row mb-4">
		<label>카테고리</label>
		<select name="lecCategoryName" required class="form-input">
			<option value="">선택하세요</option>
			<c:forEach var="val" items="${lecCategoryList}">
				<option value="${val}" ${placeVO.lecCategoryName == val ? 'selected' : ''}>${val}</option>
			</c:forEach>
		</select>
	</div>
	<div class="row mb-4">
		<label>강의장 상세내용</label>
		<textarea rows="5" cols="20" name="placeDetail" required class="form-input">${placeVO.placeDetail}</textarea>
	</div>
	<div class="row mb-4">
		<label>장소 등록일</label>
		<input type="text" name="placeRegistered" required class="form-input" value="${placeVO.placeRegistered}">
	</div>		
	<div class="row mb-4">
		<label class="form-block">대여 시작일</label>
		<input type="date" name="placeStart" required class="form-input form-inline" value="${placeVO.placeStart}">
	</div>
	<div class="row mb-4">
		<label class="form-block">대여 마감일</label>
		<input type="date" name="placeEnd" required class="form-input form-inline" value="${placeVO.placeEnd}">
	</div>
	<div class="row mb-4">
		<label>최저 대여료</label>
		<input type="number" name="placeMin" required class="form-input" value="${placeVO.placeMin}">
	</div>
	<div class="row mb-4">
		<label>최고 대여료</label>
		<input type="number" name="placeMax" required class="form-input" value="${placeVO.placeMax}">
	</div>
	<div class="row mb-4">
		<label class="mail_name">이메일</label>
	 	<div class="mail_input_box"> 
			<input type="text" id="idMail" name="email_id" class="rowChk" required> @
			<input type="text" id="inputMail" name="email_domain" required readonly>
			<select id="emailBox" name="emailBox" required>
				<option value="" class="pickMail">이메일 선택</option>
				<option value="directly">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="nate.com">nate.com</option>
			</select>
			<input type="hidden" name="placeEmail" class="mail_input" >
		</div>
	</div>
	<div class="row mb-4">
		<label class="phone_name">핸드폰 번호</label>
		<div class="phone_wrap">
	 			<input type="text" id="phone1" name="phone1" maxlength=3 required placeholder="000" class="phone"> -
				<input type="text" id="phone2" name="phone2" maxlength=4  required placeholder="0000" class="phone"> -
				<input type="text" id="phone3" name="phone3" maxlength=4  required placeholder="0000" class="phone">	
				<input type="hidden" name="placePhone" id="phoneNum">
		</div>
	</div>
	<div class="row mb-4">
		<label>강의장 주소</label>
		 	<input type="text" name="placePostcode" placeholder="우편번호" readonly id="placePostcode">
			 	<button type="button" id="kakao_Address" class="find-address-btn" value="주소찾기">
			 	주소 찾기
			 	</button>
		<label>강의장 상세주소</label>
			<input type="text" id="placeAddress" name="placeAddress" placeholder="상세 주소" required readonly>
		 <label>강의장 상세주소</label>
			<input type="text" id="placeDetailAddress" name="placeDetailAddress" placeholder="상세 주소">
			<input type="hidden" name="address" >
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
						<span id="fileDropZoneDefaultText">파일을 여기에 드래그하여 첨부해 보세요.</span>
					</div>
	 			</c:otherwise>
	 		</c:choose>
 		</div>
 	</div>
	<div class="row mb-4">
		<input type="button" id="placeForm_submitBtn" value="수정 완료" class="form-btn">
	</div>
	<div id="orgFileData" class="d-none">
		<c:forEach items="${fileList}" var="file">
			<div data-server-idx="${file.placeFileIdx}" data-name="${file.placeFileUserName}" data-size="${file.placeFileSize}"></div> 
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
