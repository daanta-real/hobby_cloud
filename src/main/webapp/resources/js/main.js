
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


// 라이브러리. 문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", () => {

	// 모달 변수 정의
	window.modal = new bootstrap.Modal(document.getElementById("modal"), {
	    keyboard: false
	});
	
});
