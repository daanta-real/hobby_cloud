


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
		boxObj.imgEl.src = fileImageStorePath + oneFile.idx;
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
			boxObj.imgEl.src = CONFIG_ROOTPATH + "/resources/img/normalFile.png";
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
	// 삭제대상 fileIdx 획득
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
	// 삭제예약된 fileIdx 획득
	const serverIdx = target.getAttribute("data-server-idx");
	// fileDeleteTargets 배열에서 fileIdx를 뺀다.
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
	let formData = new FormData(document.querySelector(".fileUploadForm"));
	
	// formData에 파일 정보 모두 추가
	for(var i in fileStageArr) formData.append("attach", fileStageArr[i]);
	
	// formData에 삭제 대상 파일 정보 추가
	fileDeleteTargets.map((idx) => { formData.append("fileDelTargetList", idx)});
	
	// 완성된 전체 formData 확인
	console.log("완성된 formData:");
	for (var p of formData) console.log(p);

	// AXIOS를 이용하여 FORM DATA 제출
	axios.post(fileSubmitAjaxPage, formData, {
		headers: { "Content-type": "multipart/form-data" }
	}).then((response) => {
		console.log("성공.\n", response.data);
		location.href = response.data;
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
    document.getElementById("fileUploadForm_submitBtn").addEventListener("click", sendForm);

});
