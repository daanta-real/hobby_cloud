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
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			청원
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>${PetitionsVO.petitionsName }</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5 container">
			<!-- 글내용 -->
			<div class="row justify-content-end">
				등록일 : ${PetitionsVO.petitionsRegistered}
				|
				작성자 : ${PetitionsVO.memberNick}
				|
				조회수 : ${PetitionsVO.petitionsViews}
			</div>
			<div class="row">
			${PetitionsVO.petitionsDetail }
			<c:forEach var="PetitionsFileDto" items="${list}"> 
<img src="${pageContext.request.contextPath}/petitions/file/${PetitionsFileDto.petitionsFileIdx}" width="30%" 
class="image image-round image-border">
</c:forEach>
			</div>
			<!-- 각종 버튼들 -->
			<nav class="row p-0 pt-4 d-flex justify-content-end">
				<a href="${pageContext.request.contextPath}/petitions/list"
				 class="col-auto btn btn-sm btn-outline-primary mx-1">목록 보기</a>
				<a href="${root }/petitions/write" class="col-auto btn btn-sm btn-outline-primary mx-1">글 작성</a>
				<a href="${pageContext.request.contextPath}/petitions/edit?petitionsIdx=${PetitionsVO.petitionsIdx }"
				 class="col-auto btn btn-sm btn-secondary mx-1">수정</a>
				<a href="${pageContext.request.contextPath}/petitions/delete?petitionsIdx=${PetitionsVO.petitionsIdx }" 
				class="col-auto btn btn-sm btn-danger mx-1">삭제</a>
				
			</nav>
		</div>
	</SECTION>
	<!-- 페이지 내용 끝. -->
	
</ARTICLE>
<!-- 페이지 영역 끝 -->

<!-- 댓글 작성 -->
<!-- 게시판 댓글 작성 -->
<h1>댓글</h1>

<form id="insert-form">
	내용 : <input type="text" name="noticeReplyDetail"> <br> 
	<input	type="hidden" name="noticeIdx" value="${NoticeVO.noticeIdx}">
	<input type="hidden" name="memberIdx" value="${login }">
	<button type="submit">등록</button>
</form>

<!-- 댓글 목록 -->
<!-- 게시판 댓글 목록 -->
<template id="noticeVO-template">
<div class="item">
	<span class="noticeReplyIdx">{{noticeReplyIdx}}</span> <span
		class="memberNick">{{memberNick}}</span> <span
		class="noticeReplyDetail">{{noticeReplyDetail}}</span> <span
		class="noticeReplyDate">{{noticeReplyDate}}</span>
	<button class="edit-btn" data-noticereply-idx="{{noticeReplyIdx}}">수정</button>
	<button class="remove-btn" data-noticereply-idx="{{noticeReplyIdx}}">삭제</button>
</div>
</template>

<div id="result"></div>

</DIV></SECTION>
<!-- 본문 대구역 끝 -->

<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>
<!-- 댓글 등록구현 -->
<script>
$(function(){
	//처음 들어오면 목록 출력
	loadList();
	//#insert-form이 전송되면 전송 못하게 막고 ajax로 insert
	$("#insert-form").submit(function(e){
		//this == #insert-form
		e.preventDefault();
		
		var dataValue = $(this).serialize();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/noticeReply/insert",
			type:"post",
			data : dataValue,
			//dataType 없음
			success:function(resp){
				console.log("성공", resp);
			
				//주의 : this 는 form이 아니다(this는 함수를 기준으로 계산)
				//jQuery는 reset() 명령이 없어서 get(0)으로 javascript 객체로 변경
				//$("#insert-form").get(0).reset();
				$("#insert-form")[0].reset();
				
				//성공하면 목록 갱신
				loadList();
			},
			error:function(e){
				console.log("실패", e);
				console.log(dataValue);
			}
		});
	});
});

//댓글 목록 리스트
function loadList(){
	var noticeIdxValue = $("#noticeIdxValue").data("notice-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/noticeReply/list",
		type:"get",
		data:{
			noticeIdx:noticeIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
			$("#result").empty();//내부영역 청소
			for(var i=0; i<resp.length; i++){
				var template = $("#noticeReplyVO-template").html();
				
				template = template.replace("{{noticeReplyIdx}}",resp[i].noticeReplyIdx);
				template = template.replace("{{noticeReplyIdx}}",resp[i].noticeReplyIdx);
				template = template.replace("{noticeReplyIdx}}",resp[i].noticeReplyIdx);
				template = template.replace("{{memberNick}}",resp[i].memberNick);
				template = template.replace("{{noticeReplyReplyDetail}}",resp[i].noticeReplyDetail);
				template = template.replace("{{noticeReplyDate}}",resp[i].noticerReplyDate);
				
				var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
				
				console.log(tag.find(".remove-btn"));
				
				//댓글 삭제
				tag.find(".remove-btn").click(function(){
					console.log("누름");
					deleteReply($(this).data("noticereply-idx"));
				});
				
				//댓글 수정
				tag.find(".edit-btn").click(function(){
					
					var gatherReplyIdx =$(this).prevAll(".gatherReplyIdx").text();
					var memberNick =$(this).prevAll(".memberNick").text();
					var gatherReplyDetail =$(this).prevAll(".gatherReplyDetail").text();
					var gatherReplyDate =$(this).prevAll(".gatherReplyDate").text();
					
					var form =$("<form>");
					console.log(form);
					
					
					form.append("<input type='hidden' name='gatherReplyIdx' value='"+gatherReplyIdx+"'>");
					form.append("<input type='text' name='gatherReplyDetail' value='"+gatherReplyDetail+"'>");
					form.append("<button type='submit'>수정</button>");
			
					form.submit(function(e){
						e.preventDefault();
						
						
					var dataValue=$(this).serialize();			
					$.ajax({
						url:"${pageContext.request.contextPath}/gatherData/replyEdit",
						type:"post",
						data:dataValue,
						success:function(resp){
							$("#result").empty();
							loadList();
						},
						error:function(e){}
					});
							
				});
					
					var div = $(this).parent();
					console.log(div);
					div.html(form);
				
				
				}); 
					$("#result").append(tag);
				} 
			 
		},
		error:function(e){
			console.log("실패",e);
		}
	});
}
</script>
<%--원래 청원상세
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="admin" value="${memberGrade=='관리자' }"></c:set>
<c:set var="login" value="${memberIdx != null }"></c:set>



<h2>${PetitionsVO.petitionsIdx}번 게시글</h2>

<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${PetitionsVO.petitionsName }</h3>
			</td>
		</tr>
		<tr>
			<td>
				등록일 : ${PetitionsVO.petitionsRegistered}
				|
				작성자 : ${PetitionsVO.memberNick}
				|
				조회수 : ${PetitionsVO.petitionsViews}
			</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td>
				<pre>${PetitionsVO.petitionsDetail }</pre>
				<c:forEach var="PetitionsFileDto" items="${list}"> 
<img src="${pageContext.request.contextPath}/petitions/file/${PetitionsFileDto.petitionsFileIdx}" width="30%" 
class="image image-round image-border">
</c:forEach>
			</td>
		</tr>
		<tr>
			<td align="right">
			<c:if test="${login }">
				<a href="write">글쓰기</a>
				</c:if>
				<a href="${pageContext.request.contextPath}/petitions/list">목록보기</a>
				<c:if test="${login }">
				<a href="${pageContext.request.contextPath}/petitions/edit?petitionsIdx=${PetitionsVO.petitionsIdx }">수정하기</a>
				<a href="${pageContext.request.contextPath}/petitions/delete?petitionsIdx=${PetitionsVO.petitionsIdx }">삭제하기</a>
				</c:if>
	
	</tbody>
</table>
<br><br>
<!-- 댓글란 -->
--%>