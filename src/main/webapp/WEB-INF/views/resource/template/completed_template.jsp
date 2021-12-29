<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<HTML LANG="ko">

<HEAD>

<META charset="UTF-8">
<META http-equiv="X-UA-Compatible" content="IE=edge">
<META name="viewport" content="width=device-width, initial-scale=1.0">
<TITLE>HobbyCloud - [여기다가 타이틀이름 쓰세요. []는 제거하시구요~]</TITLE>

<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet" href="https://bootswatch.com/5/journal/bootstrap.css">
<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<!-- JQuery 3.6.0 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- XE Icon -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<STYLE type='text/css'>

/* 공통 속성 */
* { font-family: 'Noto Sans KR', sans-serif !important; }
.flex { display:flex; }
.flexCol { flex-direction:column; }
.flexRow { flex-direction:row; }
.flexJus { justify-content:center; }
.flexAli { align-items:center; }

/* 엘레멘트별 속성 */
NAV .navbar-brand { font-size:25px; padding-top:0; text-transform: capitalize; line-height: 40px; }
HEADER .subject { font-weight:900; box-sizing: border-box; width:fit-content; margin:-3px; }
FOOTER { background:var(--bs-gray-400); }

/* 미디어쿼리 속성 */
@media (max-width: 992px) { /* ~모바일 */
    .container { max-width: 100%; }
    FOOTER { font-size:.6rem; }
}
@media (min-width: 992px) { /* PC~ */
    .container { max-width: 940px; }
    FOOTER { font-size:.8rem; }
}
@media (min-width: 1200px) {
    .container { max-width: 1130px; }
    FOOTER { font-size:1rem; }
}

/* 클릭 시 확대되는 애니메이션 */
@keyframes heartbeat {
    0% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

/* 디버그용 */
/*HEADER { background:url("https://cdn.pixabay.com/photo/2021/12/09/20/58/christmas-cookies-6859116_960_720.jpg"); }*/
FOOTER { font-weight:100; }
    
</STYLE>
    
<SCRIPT type='text/javascript'>

// 엘리먼트 획득
var getEl = (id) => document.getElementById(id);

// GET 파라미터 가져오기 - 없으면 '' 회신
function getParam(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
    var results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// 다른 이벤트로의 버블링을 차단하는 메소드
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

// 디버그용 - 랜덤한 css html 보더 설정
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

</SCRIPT>
    
</HEAD>

<BODY>

<NAV class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">

        <!-- 사이트명, 항상 표시 -->
        <a class="navbar-brand" href="#">HobbyCloud.</a>

        <!-- 햄버거, 모바일에서만 표시 -->
        <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarColor01"
            aria-controls="navbarColor01" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 메뉴바. PC에서는 항상 표시. 모바일에서는 기본 숨김 + 햄버거 클릭 시에만 표시 -->
        <div class="collapse navbar-collapse" id="navbarColor01">

            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Home
                        <span class="visually-hidden">(current)</span>
                </a></li>
                <li class="nav-item"><a class="nav-link" href="#">강좌</a></li>
                <li class="nav-item"><a class="nav-link" href="#">소모임</a></li>
                <li class="nav-item"><a class="nav-link" href="#">청원</a></li>
                <li class="nav-item"><a class="nav-link" href="#">공지</a></li>
                <li class="nav-item dropdown"><a
                    class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
                    href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a> <a
                            class="dropdown-item" href="#">Another action</a> <a
                            class="dropdown-item" href="#">Something else here</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
                    </div>
                </li>
            </ul>

            <form class="d-flex">
                <input class="form-control me-sm-1" type="text"
                    placeholder="Search">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
            </form>

            <form class="d-flex">
                <input class="form-control me-sm-1" type="text" placeholder="ID">
                <input class="form-control me-sm-1" type="password" placeholder="Password">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Login</button>
            </form>
            
        </div>
    </div>
</NAV>

<HEADER class='container p-1 mt-md-5 mt-sm-3 mb-md-3'>
<div class='row border-bottom border-secondary border-1 m-1 mb-1 pt-3'>
<span class="subject border-bottom border-primary border-5 fs-1">
<!-- 제목 영역 시작 -->
강좌: JSP 잘 하는 법
<!-- 제목 영역 끝 -->
</span>
</div>
</HEADER>

<SECTION class='container p-3'>
<!-- 페이지 내용 시작 -->
본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내용본내
<!-- 페이지 내용 끝. -->
</SECTION>

<FOOTER class='container-fluid mt-md-5 mt-sm-3 p-lg-3 p-md-1 text-secondary'>
	<div class="row">
		<ul class="container list-unstyled">
			<li class="row m-1">회사소개 | 이용약관 | 개인정보처리방침 | 사업자 정보확인 | 콘텐츠산업진흥법에의한 표시</li>
			<li class="row m-1 mt-lg-4 mb-lg-4 mt-md-0 mb-md-0">고객행복센터 1355-4533 오전 9시 - 새벽 3시</li>
			<li class="row m-1">(주) 하비클라우드컴퍼니</li>
			<li class="row m-1">주소 : 서울특별시 강남구 강남대로 001, 777타워 77층</li>
			<li class="row m-1">대표이사 : 왕인빈 | 사업자등록번호: 001-01-00334</li>
			<li class="row m-1">통신판매번호 : 2021-서울강남-01001 | 관광사업자 등록번호: 제1001-01호</li>
			<li class="row m-1">전화번호 : 1355-4533</li>
			<li class="row m-1">전자우편주소 : welcome@hobbycloud.kr</li>
			<li class="row m-1">Copyright HobbyCloud Corp. All rights reserved</li>
			<li class="row m-1">로그인 정보: No. <%=request.getSession().getAttribute("memberIdx")%> <%=request.getSession().getAttribute("memberNick")%>님 (<%=request.getSession().getAttribute("memberId")%> - <%=request.getSession().getAttribute("memberGrade")%>등급)</li>
		</ul>
	</div>
</FOOTER>

</BODY>

</HTML>