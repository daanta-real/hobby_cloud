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
<ASIDE id="accordionSideMenu" class="accordion col-lg-2">
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading1">
			<button class="accordion-button" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse1"
				aria-expanded="true" aria-controls="collapse1">회원 관리</button>
		</h2>
		<div id="collapse1" class="accordion-collapse collapse show"
			aria-labelledby="heading1" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">회원 통계</div>
			<div class="accordion-body px-3 py-2">회원 관리</div>
			<div class="accordion-body px-3 py-2">1:1 채팅 이력</div>
			<div class="accordion-body px-3 py-2">채널 채팅 이력</div>
			<div class="accordion-body px-3 py-2">회원 등급</div>
		</div>
	</div> 
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading2">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse2"
				aria-expanded="false" aria-controls="collapse2">
				강좌</button>
		</h2>
		<div id="collapse2" class="accordion-collapse collapse"
			aria-labelledby="heading2" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">강좌 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading3">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse3"
				aria-expanded="false" aria-controls="collapse3">
				장소</button>
		</h2>
		<div id="collapse3" class="accordion-collapse collapse"
			aria-labelledby="heading3" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">장소 관리</div>
			<div class="accordion-body px-3 py-2">장소담당자 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading4">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse4"
				aria-expanded="false" aria-controls="collapse4">
				소모임</button>
		</h2>
		<div id="collapse4" class="accordion-collapse collapse"
			aria-labelledby="heading4" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">소모임 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading5">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse5"
				aria-expanded="false" aria-controls="collapse5">
				청원</button>
		</h2>
		<div id="collapse5" class="accordion-collapse collapse"
			aria-labelledby="heading5" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">청원 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading6">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse6"
				aria-expanded="false" aria-controls="collapse6">
				공지</button>
		</h2>
		<div id="collapse6" class="accordion-collapse collapse"
			aria-labelledby="heading6" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">공지 관리</div>
		</div>
	</div>
	<div class="accordion-item">
		<h2 class="accordion-header" id="heading7">
			<button class="accordion-button p-3 collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse7"
				aria-expanded="false" aria-controls="collapse7">
				수익</button>
		</h2>
		<div id="collapse7" class="accordion-collapse collapse"
			aria-labelledby="heading7" data-bs-parent="#accordionSideMenu"
			style="">
			<div class="accordion-body px-3 py-2">광고 관리</div>
			<a class="accordion-body px-3 py-2" href="${root}/admin/pay/list">결제이력 관리</a>
		</div>
	</div>
</ASIDE>
<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			결제 관리
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>댓글 목록</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				
				<!--
				댓글 및 대댓글 depth에 따라 클래스명을 다르게 붙이면 된다.
				0레벨: 아무 것도 안 붙임
				1레벨: replyDepth1
				2레벨: replyDepth2
				-->
				<div class="card mb-2 border border-1 border-secondary p-0">
					<div class="card-header d-flex align-items-center p-1 px-2">
						<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
						<span class="memberReplyNick">내 닉네임</span>
						<span class="memberReplyRegistered ms-auto">2000-00-00 15:23</span>
					</div>
					<div class="card-body position-relative p-1 px-2">
						<div class="card-text p-1 px-3">[댓글 내용]</div>
						<div class="floatRightTop position-absolute top-0 end-0 p-1">
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">삭제</button>
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">수정</button>
						</div>
					</div>
				</div>
				<div class="card mb-2 border border-1 border-secondary p-0 replyDepth1">
					<div class="card-header d-flex align-items-center p-1 px-2">
						<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
						<span class="memberReplyNick">내 닉네임</span>
						<span class="memberReplyRegistered ms-auto">2000-00-00 15:23</span>
					</div>
					<div class="card-body position-relative p-1 px-2">
						<div class="card-text p-1 px-3">[댓글 내용]</div>
						<div class="floatRightTop position-absolute top-0 end-0 p-1">
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">삭제</button>
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">수정</button>
						</div>
					</div>
				</div>
				<div class="card mb-2 border border-1 border-secondary p-0 replyDepth2">
					<div class="card-header d-flex align-items-center p-1 px-2">
						<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
						<span class="memberReplyNick">내 닉네임</span>
						<span class="memberReplyRegistered ms-auto">2000-00-00 15:23</span>
					</div>
					<div class="card-body position-relative p-1 px-2">
						<div class="card-text p-1 px-3">[댓글 내용]</div>
						<div class="floatRightTop position-absolute top-0 end-0 p-1">
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">삭제</button>
							<button type="button" class="btn btn-sm btn-secondary p-1 me-1" onclick="modifyReply();">수정</button>
						</div>
					</div>
				</div>
				
				<form name="searchForm" method="get" class="row">
					<div class="form-group mb-4 col-md-6 col-lg-4">
						<label for="searchForm_memberIdx" class="form-label mb-0">회원 번호</label>
						<input name="memberIdx" id="searchForm_memberIdx" type="number" class="form-control" placeholder="회원 번호를 입력하세요" value="${param.memberIdx}">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group mb-4 col-md-6 col-lg-4">
						<label for="searchForm_memberId" class="form-label mb-0">ID</label>
						<input name="memberId" id="searchForm_memberId" type="text" class="form-control" placeholder="회원 아이디를 입력하세요" value="${param.memberId}">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group mb-4 col-md-6 col-lg-4">
						<label for="searchForm_memberNick" class="form-label mb-0">닉네임</label>
						<input name="memberNick" id="searchForm_memberNick" type="text" class="form-control" placeholder="닉네임을 입력하세요" value="${param.memberNick}">
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">결제 금액</span>
						</div>
						<div class="row d-flex flex-start align-items-center">
							<div class="col-5">
								<input name="paidPrice_min" id="searchForm_paidPrice_min" type="number" class="form-control" placeholder="최소 금액" value="${param.paidPrice_min}">
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="paidPrice_max" id="searchForm_paidPrice_max" type="number" class="form-control" placeholder="최대 금액" value="${param.paidPrice_max}">
							</div>
						</div>
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="form-group mb-4 col-lg-6">
						<label for=searchForm_paidPrice_min class="form-label mb-0 d-block">결제여부</label>
						<div class="btn-group w-100">
							<input name="paidStatusList" type="checkbox" value="1" class="btn-check" id="chkbox_paid_done" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '1').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="chkbox_paid_done">결제 완료</label>
							<input name="paidStatusList" type="checkbox" value="0" class="btn-check" id="chkbox_paid_canceled" autocomplete="off"  ${paramValues.paidStatusList.stream().anyMatch(v->v == '0').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="chkbox_paid_canceled">결제 취소</label>
						</div>
						<!-- <small id="searchForm_memberIdx_tip" class="form-text text-muted">회원 번호를 입력하십시오.</small>-->
					</div>
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8">검색</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>검색 결과</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">결제번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">회원번호</th>
								<th scope="col" class="text-center align-middle text-nowrap">ID</th>
								<th scope="col" class="text-center align-middle text-nowrap">닉네임</th>
								<th scope="col" class="text-center align-middle text-nowrap">TID</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제일시</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제액</th>
								<th scope="col" class="text-center align-middle text-nowrap">결제상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="PaidVO" items="${paidList}">
								<c:set var="paidStatus" value="${PaidVO.paidStatus == '1'.charAt(0)}" />
								<tr class="cursor-pointer">
									<td class="text-center align-middle text-nowrap">${PaidVO.paidIdx}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberIdx}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberId}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.paidTid}</td>
									<td class="text-center align-middle text-nowrap">${PaidVO.paidRegisteredStr}</td>
									<td class="text-end align-middle text-nowrap">&#8361;&nbsp;<fmt:formatNumber value="${PaidVO.paidPrice}" pattern="#,###" /></td>
									<td class="text-center align-middle text-nowrap text-${paidStatus ? 'success' : 'danger'}">
										<c:choose>
											<c:when test="${paidStatus}">
												결제 완료&nbsp;<a href="${root}/pay/cancel/${PaidVO.paidIdx}" class="btn btn-warning btn-sm">결제 취소</a>
											</c:when>
											<c:otherwise>
												결제 취소됨
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
				<button type="button"
					class="col-auto btn btn-sm btn-outline-primary">목록으로</button>
				<ul class="col-auto pagination pagination-sm m-0">
					<li class="page-item disabled">
						<a class="page-link" href="#" tabindex="-1" aria-disabled="true">«</a>
					</li>
					<li class="page-item active">
						<a class="page-link" href="#">1</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">2</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">3</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">»</a>
					</li>
				</ul>
				<button type="button"
					class="col-auto btn btn-sm btn-outline-primary">글작성</button>
			</nav>
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
