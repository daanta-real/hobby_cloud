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
<style type="text/css">

.replyDepth1 { margin-left:3rem !important; }
.replyDepth2 { margin-left:6rem !important; }

</style>
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
		
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
			<div class="row form-group d-flex justify-content-center">
				<img src="${pageContext.request.contextPath}/resources/img/gather.png" class="w-50">
			</div>
			<div class="row form-group text-center">
			<h3>환영합니다</h3>
			</div>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>hobbycloud</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
		<div class="container">
		<nav class="row p-0 pt-4 d-flex justify-content-center">
		<div class="card border-primary mb-3 w-50">
             <div class="card-header">인삿말</div>
                <div class="card-body">
                   <h4 class="card-title">취미를 배워보자</h4>
                   <p class="card-text">hobbycloud는 평소 배우고싶던 취미를 손쇱게 강사를 찾아 배울 수 있고 가까운 사람들과 만남을 가져 함께
                   취미생활을 공유 할 수 있습니다. hobbycloud를 통해 값진 시간을 보내세요 </p>
                 </div>
              </div>
          <div class="card border-primary mb-3 w-50">
             <div class="card-header">취미종류</div>
                <div class="card-body">
                   <h4 class="card-title">다양한 취미를 만나보세요</h4>
                   <p class="card-text">운동</p>
                   <p class="card-text">요리</p>
                   <p class="card-text">문화</p>
                   <p class="card-text">예술</p>
                   <p class="card-text">IT</p>
                 </div>
              </div>
              </nav>
         <!-- 강좌소개 -->
           <div class="card mb-3">
               <h3 class="card-header">강좌소개</h3>
               <div class="card-body">
                    <h5 class="card-title">Special title treatment</h5>
                    <h6 class="card-subtitle text-muted">Support card subtitle</h6>
                </div>
             
                 <img src="${pageContext.request.contextPath}/resources/img/cook.jpeg"></rect>
                 <text x="50%" y="50%" fill="#dee2e6" dy=".3em"></text>
             </svg>
               <div class="card-body">
                   <p class="card-text">다양한 취미생활을 배워봅시다.</p>
               </div>
               <ul class="list-group list-group-flush">
                   <li class="list-group-item">강좌목록으로</li>
                   <li class="list-group-item">소모임으로</li>
                   <li class="list-group-item">청원으로</li>
               </ul>
              <div class="card-body">
                  <a href="#" class="card-link">강좌목록으로</a>
                  <a href="#" class="card-link">소모임으로</a>
              </div>
      <div class="card-footer text-muted">
    2 days ago
      </div>
          </div>
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
