<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 강좌 목록</TITLE>
<style type="text/css">
.tableImgBox { max-width:min-content; }
.tableImg { max-width:7rem; max-height:7rem; width:100%; object-fit: cover; }
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
			강좌 목록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>검색 조건</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
				<form method="post" class="row">
					<div class="form-group mb-4 col-6">
						<label for="searchForm_lecIdx" class="form-label mb-0">강좌 번호</label>
						<input name="lecIdx" id="searchForm_lecIdx" type="number" class="form-control" placeholder="강좌 번호를 입력하세요" value="${lecSearchVO.lecIdx}">
					</div>
					<div class="form-group mb-4 col-12">
						<label for=searchForm_lecLocRegion class="form-label mb-0 d-block">지역</label>
						<div class="btn-group w-100 flex-wrapper">
							<input name="lecLocRegion" type="radio" value="서울" class="btn-check" id="Seoul" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '서울').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Seoul">서울</label>
							<input name="lecLocRegion" type="radio" value="경기" class="btn-check" id="Gyeonggi" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '경기').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Gyeonggi">경기</label>
							<input name="lecLocRegion" type="radio" value="부산" class="btn-check" id="Busan" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '부산').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Busan">부산</label>
							<input name="lecLocRegion" type="radio" value="인천" class="btn-check" id="Incheon" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '인천').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Incheon">인천</label>
							<input name="lecLocRegion" type="radio" value="대구" class="btn-check" id="Daegu" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '대구').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Daegu">대구</label>
							<input name="lecLocRegion" type="radio" value="대전" class="btn-check" id="Daejeon" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '대전').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Daejeon">대전</label>
							<input name="lecLocRegion" type="radio" value="광주" class="btn-check" id="Gwangju" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '광주').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Gwangju">광주</label>
							<input name="lecLocRegion" type="radio" value="울산" class="btn-check" id="Ulsan" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '울산').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Ulsan">울산</label>
							<input name="lecLocRegion" type="radio" value="세종" class="btn-check" id="Sejong" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '세종').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Sejong">세종</label>
							<input name="lecLocRegion" type="radio" value="강원" class="btn-check" id="Gangwon" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '강원').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Gangwon">강원</label>
							<input name="lecLocRegion" type="radio" value="제주" class="btn-check" id="Jeju" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '제주').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Jeju">제주</label>
							<input name="lecLocRegion" type="radio" value="충청북" class="btn-check" id="Chungcheongbuk" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '충북').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Chungcheongbuk">충북</label>
							<input name="lecLocRegion" type="radio" value="충청남" class="btn-check" id="Chungcheongnam" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '충남').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Chungcheongnam">충남</label>
							<input name="lecLocRegion" type="radio" value="전라북" class="btn-check" id="Jeollabuk" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '전북').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Jeollabuk">전북</label>
							<input name="lecLocRegion" type="radio" value="전라남" class="btn-check" id="Jeollanam" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '전남').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Jeollanam">전남</label>
							<input name="lecLocRegion" type="radio" value="경상북" class="btn-check" id="Gyeongsangbuk" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '경북').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Gyeongsangbuk">경북</label>
							<input name="lecLocRegion" type="radio" value="경상남" class="btn-check" id="Gyeongsangnam" autocomplete="off"  ${paramValues.lecLocRegion.stream().anyMatch(v->v == '경남').get() ? 'checked' : ''}>
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="Gyeongsangnam">경남</label>
							<input name="lecLocRegion" type="radio" value="" class="btn-check" id="null" autocomplete="off">
							<label class="btn btn-outline-primary text-nowrap rounded m-1" for="null">선택해제</label>
						</div>
					</div>
					<div class="form-group mb-4 col-12">
						<label for=searchForm_lecCategoryName class="form-label mb-0 d-block">카테고리</label>
						<div class="btn-group w-100 flex-wrapper">
							<c:forEach var="lecCategory" items="${lecCategoryList}" varStatus="status">
								<input name="lecCategoryName" type="checkbox" value="${lecCategory}" class="btn-check"
									id="category${status.count}" autocomplete="off"
									${paramValues.lecCategoryName.stream().anyMatch(v->v == lecCategory).get() ? 'checked' : ''}>
								<label class="btn btn-outline-primary text-nowrap rounded m-1" for="category${status.count}">${lecCategory}</label>
							</c:forEach>
						</div>
					</div>
					<div class="form-group mb-4 col-md-6">
						<label for="searchForm_lecName" class="form-label mb-0">강좌 이름</label>
						<input name="lecName" id="searchForm_lecName" type="text" class="form-control" placeholder="강좌명을 입력하세요" value="${param.lecName}">
					</div>
					<div class="form-group mb-4 col-md-6">
						<label for="searchForm_memberNick" class="form-label mb-0">강사 이름</label>
						<input name="memberNick" id="searchForm_memberNick" type="text" class="form-control" placeholder="강사 이름을 입력하세요" value="${param.memberNick}">
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">강좌 가격</span>
						</div>
						<div class="row d-flex flex-start justify-content-center">
							<div class="col-5">
								<input name="minPrice" id="searchForm_minPrice" type="number" class="form-control" placeholder="최소 금액" value="${param.minPrice}" min=1000 max=1000000>
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="maxPrice" id="searchForm_maxPrice" type="number" class="form-control" placeholder="최대 금액" value="${param.maxPrice}" min=1000 max=1000000>
							</div>
						</div>
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">강좌 인원수</span>
						</div>
						<div class="row d-flex flex-start justify-content-center">
							<div class="col-5">
								<input name="minCount" id="searchForm_minCount" type="number" class="form-control" placeholder="최소 인원수" value="${param.minCount}" min=1000 max=1000000>
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="maxCount" id="searchForm_maxCount" type="number" class="form-control" placeholder="최대 인원수" value="${param.maxCount}" min=1000 max=1000000>
							</div>
						</div>
					</div>
					<div class="form-group mb-4 col-md-6 container">
						<div class="row">
							<span class="form-label mb-0 text-nowrap">강좌 수</span>
						</div>
						<div class="row d-flex flex-start justify-content-center">
							<div class="col-5">
								<input name="minConCount" id="searchForm_minConCount" type="number" class="form-control" placeholder="최소 강좌수" value="${param.minConCount}" min=5 max=100>
							</div>
							<div class="col-auto d-flex justify-content-center align-items-center p-0">
								<span>~</span>
							</div>
							<div class="col-5">
								<input name="maxConCount" id="searchForm_maxConCount" type="number" class="form-control" placeholder="최대 강좌수" value="${param.maxConCount}" min=5 max=100>
							</div>
						</div>
					</div>
					<div class="row d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-danger col-sm-12 col-md-9 col-xl-8">검색</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 목록</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
<!-- 								<th scope="col" class="text-center align-middle text-nowrap">번호</th> -->
								<th scope="col" class="text-center align-middle text-nowrap">카테고리</th>
								<th scope="col" class="text-center align-middle text-nowrap tableImgBox">썸네일</th>
								<th scope="col" class="text-center align-middle text-nowrap">강좌</th>
								<th scope="col" class="text-center align-middle text-nowrap">강사</th>
								<th scope="col" class="text-center align-middle text-nowrap">수강료</th>
								<th scope="col" class="text-center align-middle text-nowrap">강의수</th>
								<th scope="col" class="text-center align-middle text-nowrap">수강인원</th>
								<th scope="col" class="text-center align-middle text-nowrap">지역</th>
								<c:if test="${memberGrade == '관리자' and memberIdx != null}">
									<th scope="col" class="text-center align-middle text-nowrap">메뉴</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="lecListVO" items="${list}">
								<tr class="cursor-pointer" onclick="location.href='${root}/lec/detail/${lecListVO.lecIdx}'">
<%-- 									<td class="text-center align-middle text-nowrap">${lecListVO.lecIdx}</td> --%>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecCategoryName}</td>
									<td class="text-center align-middle text-nowrap p-0 tableImgBox">
										<img src="${root}/lec/lecFile/${lecListVO.lecFileIdx}" class="m-0 p-0 tableImg">
									</td>
									<td class="text-center align-middle text-nowrap"> ${lecListVO.lecName}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">&#8361;&nbsp;<fmt:formatNumber value="${lecListVO.lecPrice}" pattern="#,###" /></td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecContainsCount}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecHeadCount}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecLocRegion}</td>
									<c:if test="${memberGrade == '관리자'} and ${memberIdx != null}">
										<td class="text-center align-middle text-nowrap">
											<a href="edit/${lecListVO.lecIdx}">수정</a>
											<a href="delete/${lecListVO.lecIdx}">삭제</a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:forEach var="lecListVO" items="${listSearch}">
								<tr class="cursor-pointer" onclick="location.href='${root}/lec/detail/${lecListVO.lecIdx}'">
<%-- 									<td class="text-center align-middle text-nowrap">${lecListVO.lecIdx}</td> --%>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecCategoryName}</td>
									<td class="text-center align-middle text-nowrap p-0 tableImgBox">
										<img src="${root}/lec/lecFile/${lecListVO.lecFileIdx}" class="m-0 p-0 tableImg">
									</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecName}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.memberNick}</td>
									<td class="text-center align-middle text-nowrap">&#8361;&nbsp;<fmt:formatNumber value="${lecListVO.lecPrice}" pattern="#,###" /></td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecContainsCount}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecHeadCount}</td>
									<td class="text-center align-middle text-nowrap">${lecListVO.lecLocRegion}</td>
									<c:if test="${memberGrade == '관리자'} and ${memberIdx != null}">
										<td class="text-center align-middle text-nowrap">
											<a href="edit/${lecListVO.lecIdx}">수정</a>
											<a href="delete/${lecListVO.lecIdx}">삭제</a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<nav class="row p-0 pt-4 d-flex justify-content-between">
			<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/lec/list';">전체 목록</a></button>	
				<ul class="col-auto pagination pagination-sm m-0">
					<c:if test="${pageMaker.prev}">
						<li class="page-item disabled"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"
						> ◁ </a></li>
					</c:if> 
				
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li class="page-item ${param.page == idx ? 'active' : ''}"><a  class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
					</c:forEach>
				
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">&raquo;</a></li>
					</c:if> 
				</ul>
					<c:choose>
						<c:when test="${memberIdx != null and memberGrade == '강사'}">
							<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/lec/register';">신규 강좌 추가</a></button>
						</c:when>
						<c:otherwise>
							<button type="button" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/my/lec/';">내 강좌 보기</a></button>
						</c:otherwise>
					</c:choose>	
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