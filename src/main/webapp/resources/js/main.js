
// 라이브러리. 엘리먼트 획득
var getEl = (id) => document.getElementById(id);

// 라이브러리. 엘리먼트 하나 생성해서 리턴 - class: 클래스리스트, id:아이디, value:값, text:텍스트, html:HTML
function createEl(name, param) {
 var el = document.createElement(name);
 if(param != undefined) {
     if(param.class != undefined) {
         if(Array.isArray(param.class)) for(var i in param.class) el.classList.add(param.class[i]);
         else el.classList.add(param.class);
     }
     if(param.id != undefined) el.id = param.id;
     if(param.value != undefined) el.value = param.value;
     if(param.text != undefined) el.innerText = param.text;
     if(param.html != undefined) el.innerHTML = param.html;
     if(param.attr != undefined) for(var i in param.attr) el.setAttribute(i, param.attr[i]);
     if(param.style != undefined) for(var i in param.style) el.style[i] = param.style[i];
     if(param.child != undefined) {
         if(param.child instanceof Array) for(var i = 0; i < param.child.length; i++) el.append(param.child[i]);
         else el.append(param.child);
     }
     if(param.onclick != undefined) el.onclick = param.onclick;
     if(param.src != undefined) el.src = param.src;
 }
 return el;
}

// 라이브러리. element 내의 하위노드 싹 삭제
function truncateEl(el) { while (el.firstChild) el.removeChild(el.firstChild); }

// 라이브러리. GET으로 접수된 특정 파라미터 가져오기 - 없으면 '' 회신
function getParam(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
    var results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// 라이브러리. 다른 이벤트로의 버블링을 차단하는 메소드
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

//라이브러리. 엘리먼트의 클래스명 목록에, 입력된 classTarget 들만 추가하고 나머지 classList 들은 다 제거키는 함수
//매개변수: el(대상 엘리먼트), classTarget(ON시킬 클래스명), classList(전체 클래스명 목록)
function onSpecificClasses(el, classTarget, classList) {
	el.classList.remove(...classList);
	el.classList.add([].concat(classTarget));
}

// 라이브러리. 디버그용 - 랜덤한 css html 보더 설정
function rainbow(query, styles) {
    var rndClr = ['Red', 'Lime', 'Blue', 'Yellow', 'Cyan', 'Magenta', 'Silver', 'Gray', 'Maroon', 'Olive', 'Green', 'Purple', 'Teal', 'Navy'];
    document.querySelectorAll(query).forEach((el) => {
        var rnd = Math.floor(Math.random() * rndClr.length);
        var clr = rndClr[rnd];
        el.style.border = '1px solid ' + clr;
        if(styles != undefined) for(var i in styles) el.style[i] = styles[i];
    });
}
const debug_rainbowQueryRun = () => {
    const query = document.getElementById("debug_query").value;
    console.log('"' + query + '"의 쿼리에 해당하는 레이어 레인보우화 실행됨');
    rainbow(query, { padding:"0.3rem", margin:"0.2rem" });
};

// 라이브러리. 숫자로 된 용량을 주면 MB/KB/bytes 식으로 환산해 준다.
function byteString(size, digitsLength) {
	if (size >= 1024) {
        size /= 1024;
        size = (digitsLength === undefined) ? size : size.toFixed(digitsLength);
        return size + 'KB';
    }
    else if (size >= 1024 * 1024) {
        size = size / (1024 * 1024);
        size = (digitsLength === undefined) ? size : size.toFixed(digitsLength);
        return size + 'MB';
    }
    //KB 단위보다 작을때 byte 단위로 환산
    else {
        size = (digitsLength === undefined) ? size : size.toFixed(digitsLength);
        return size + 'byte';
    }
}

// 라이브러리. 1차원 배열에서 특정 원소 제거한거 회신 (단, 첫번째 발견될때만 제거)
function arr_remove_val(arr, val) {
 var idx = arr.indexOf(val);
 if(idx > -1) arr.splice(idx, 1);
 return arr;
}

// 라이브러리. 메인화면에서 쓰인다.
// 로그인 시도하고 바로 메인페이지로 간다.
function loginSubmit() {

	// Form값 가져오기
	let formData = new FormData(document.getElementById("topLoginBox"));
	
	// 버튼 사라지게 하고 스피너 ON
	const span = document.getElementById("topLoginBtnSpan");
	const spinner = document.querySelector("#topLoginBox .spinner");
	span.style.display = "none";
	spinner.classList.add("loading");
	
	// AXIOS를 이용하여 FORM DATA 제출
	axios.post(CONFIG_ROOTPATH + "/member/login", formData
	).then((response) => {
		span.style.display = "inline-block";
		spinner.classList.remove("loading");
		location.href = CONFIG_ROOTPATH;
	}).catch((response) => {
		console.log("에러\n", response);
	});
	
}

// 라이브러리. 내가 올린 파일의 이미지를 로드시켜 준다.
// 파일 객체와 이미지 태그 엘리먼트를 넘기면,
// FileReader에 이미지 로딩을 예약하여,
// 이미지 내용물이 로드되는 대로 이미지 태그에 반영하게끔 할 수 있다.
function renderImageFromFile(file, targetEl) {
	console.log(file.name);
	const reader = new FileReader();
	reader.readAsDataURL(file);
	reader.addEventListener('load', (e) => {
		targetEl.src = e.target.result;
	});
}

// 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", () => {

	// 모달 변수 정의
	window.modal = new bootstrap.Modal(document.getElementById("modal"), {
	    keyboard: false
	}); 
	
	// FORM 제출 시 자동 실행: 비밀번호 암호화
	$("form").submit(function(e){
		
		// 이벤트 버블링 방지
		e.preventDefault();
		
		// 비번 input 태그값 암호화 반영
		$(this).find("input[type=password]").each(function(){
			var origin = $(this).val();
			var hash = CryptoJS.SHA1(origin);
			var encrypt = CryptoJS.enc.Hex.stringify(hash);
			$(this).val(encrypt);
		});
		
		// 로그인 폼일 때에 한해서 Ajax 실시하며, 그 외에는 그대로 제출 실시
		if(e.target.id === "topLoginBox") loginSubmit();
		else this.submit();

	});
	
});
