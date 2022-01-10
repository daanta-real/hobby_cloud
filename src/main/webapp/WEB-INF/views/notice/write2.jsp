<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<c:set var="login" value="${memberIdx != null }"></c:set>
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
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2 justify-content-center">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			공지사항
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>글작성</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5 container justify-content-center">
			<!-- 글내용 -->
			<div class="row justify-content-center">
				<form method="post" enctype="multipart/form-data" class="justify-content-center">

		<div class="mb-3 justify-content-center">
    <label for="" class="form-label">제목</label>
    <input type="text" name="noticeName" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    
  </div>
			
			<div class="form-group justify-content-center">
      <label for="exampleTextarea" class="form-label mt-4">내용</label>
      <textarea class="form-control" name="noticeDetail" id="exampleTextarea" rows="15" style="resize:none"
      ></textarea>
    </div>
    
    <div class="form-group justify-content-center">
      <label for="formFile" class="form-label mt-4"></label>
      <input class="form-control" type="file" id="formFile" name="attach" enctype="multipart/form-data" multiple>
    </div>
    <div class="form-row text-center">
    <div class="col-12 pt-3">
        <a href="${pageContext.request.contextPath}/notice/list"
				 class="col-auto btn  btn-secondary mx-1 my-3">취소</a>
        <button type="submit" class="btn btn-primary my-3" >등록</button>
    </div>
 </div>
</form>
			</div>
			
			<!-- 각종 버튼들 -->
		</div>
	</SECTION>
	<!-- 페이지 내용 끝. -->
	
</ARTICLE>
<!-- 페이지 영역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>

<%--나의 원래 폼 
<form method="post" enctype="multipart/form-data">
<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="noticeName" required></td>
			
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="noticeDetail" required rows="10" cols="60"></textarea>
			</td>
		</tr>
		<tr>
			<th>첨부</th>
			<td>
				<input type="file" name="attach" enctype="multipart/form-data" multiple>
			</td>
		</tr>
		</tbody>
	<tfoot>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="등록">
			</td>
		</tr>
		
	</tfoot>
</table>
</form>
--%>