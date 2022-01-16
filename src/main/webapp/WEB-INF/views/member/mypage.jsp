<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="login" value="${memberIdx != null }"></c:set>
<c:set var="Landlord" value="${memberGrade=='임대인'}"></c:set>
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<!DOCTYPE HTML>
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
			마이페이지
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
			<!-- 회원 프로필 이미지 -->
				<c:choose>
					<c:when test="${memberProfileDto == null}">
						<img src="https://via.placeholder.com/300x300?text=User">
					</c:when>
					<c:otherwise>
						<img id="" src="${pageContext.request.contextPath}/member/profile/${memberProfileDto.memberIdx}" width="30%" height="30%">										
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group col-12 text-center">
			<h2>${memberDto.memberId}</h2>
			</div>
			<div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">아이디</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberId}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
             <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">닉네임</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberNick}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">이메일</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberEmail}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">전화번호</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberPhone}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">관심분야</label>
             <input class="form-control" id="disabledInput"  value="${memberCategoryDto.lecCategoryName}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">가입일시</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberRegistered}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">포인트</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberPoint}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">주소</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberRegion}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
              <div class="form-group col-12">
            <fieldset disabled="">
             <label class="form-label" for="disabledInput">등급</label>
             <input class="form-control" id="disabledInput"  value="${memberDto.memberGradeName}" type="text" placeholder="" disabled="">
             </fieldset>
             </div>
             <nav class="row p-0 pt-4 d-flex justify-content-end">
				<a href="${root }/member/password" class="col-auto btn btn-sm btn-outline-primary mx-1">비밀번호 변경</a>
				<a href="${root }/member/edit"
				 class="col-auto btn btn-sm btn-secondary mx-1">개인정보 변경</a>
				 <a href="${root }/member/quit"
				 class="col-auto btn btn-sm btn-secondary mx-1">회원탈퇴</a>
			</nav>
			
				 <c:if test="${Landlord}"> 
				 <nav class="row p-0 pt-4 d-flex justify-content-end">
					<a href="${pageContext.request.contextPath}/place/myPlaceList" 
					class="col-auto btn btn-sm btn-secondary mx-1">내 강의장 보기</a>
				</nav>			
				</c:if>	
				 
				 <c:if test="${admin}">
				 <nav class="row p-0 pt-4 d-flex justify-content-end">
				 	<a href="${pageContext.request.contextPath}/member/updateNomal/${memberDto.memberIdx}"
					class="col-auto btn btn-sm btn-secondary mx-1">일반 회원 등록</a>
					<a href="${pageContext.request.contextPath}/member/updateTutor/${memberDto.memberIdx}"
					class="col-auto btn btn-sm btn-secondary mx-1">강사 등록</a>
					<a href="${pageContext.request.contextPath}/member/updateLandlord/${memberDto.memberIdx}"
					class="col-auto btn btn-sm btn-secondary mx-1">임대인 등록</a>
				</nav>
				</c:if>
		</div>
		</div>
		<!-- 소단원 제목 -->		
		<!-- 소단원 내용 -->		
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