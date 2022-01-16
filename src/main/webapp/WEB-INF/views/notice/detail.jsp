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
			공지사항
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>${NoticeVO.noticeName }</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5 container">
			<!-- 글내용 -->
			<div class="row justify-content-end">
				등록일 : ${NoticeVO.noticeRegistered}
				|
				작성자 : ${NoticeVO.memberNick}
				|
				조회수 : ${NoticeVO.noticeViews}
			</div>
			<div class="row">
			${NoticeVO.noticeDetail }
			<c:forEach var="NoticeFileDto" items="${list}"> 
<img src="${pageContext.request.contextPath}/notice/file/${NoticeFileDto.noticeFileIdx}" width="30%" 
class="image image-round image-border">
</c:forEach>
			</div>
			<!-- 각종 버튼들 -->
			<nav class="row p-0 pt-4 d-flex justify-content-end">
				<a href="${pageContext.request.contextPath}/notice/list"
				 class="col-auto btn btn-sm btn-outline-primary mx-1">목록 보기</a>
				<c:if test="${admin }">
				<a href="${root }/notice/write" class="col-auto btn btn-sm btn-outline-primary mx-1">글 작성</a>
				<a href="${pageContext.request.contextPath}/notice/edit?noticeIdx=${NoticeVO.noticeIdx }"
				 class="col-auto btn btn-sm btn-secondary mx-1">수정</a>
				<a href="${pageContext.request.contextPath}/notice/delete?noticeIdx=${NoticeVO.noticeIdx }" 
				class="col-auto btn btn-sm btn-danger mx-1">삭제</a>
				</c:if>
			</nav>
			
			<!-- 댓글 내역 -->
<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold box4'>댓글</div>
<!-- 소단원 내용 -->
<div class="row p-sm-2 mx-1 mb-5">
	<form id="insert-form">
		<div class="card mb-2 border border-1 border-secondary p-0">
			<div class="card-header d-flex align-items-center p-1 px-2">
				<span>댓글을 입력해주세요</span>
			</div> 
			<div class="card-body position-relative p-1 px-2">
				<input type="text" class="card-text p-1 px-3 noticeReplyDetail" name="noticeReplyDetail" placeholder="" />
				<input	type="hidden" name="noticeIdx" value="${NoticeVO.noticeIdx}" />
				<input type="hidden" name="memberIdx" value="${memberIdx}" /> 
				   
				<!-- 등록버튼 -->
				<c:choose>
					<c:when test="${login}"> 
						<button type="submit" class="btn btn-sm btn-secondary p-1 me-1">댓글 작성</button> 
					</c:when>
				</c:choose>
			</div>
			<div class="floatRightTop position-absolute top-0 end-0 p-1"></div>
		</div>
	</form>
</div>
<div id="result"></div> 
			<!-- 게시판 댓글 목록 --> 
<template id="noticeVO-template">
	<div class="card mb-2 border border-1 border-secondary p-0 item">
		<div class="card-header d-flex align-items-center p-1 px-2">
			<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" 
			src="${pageContext.request.contextPath}/member/profile/{{memberIdx}}"
			style="width:2.3rem; height:2.3rem;"/>
			<span class="memberNick">{{memberNick}}</span>
			<span class="memberReplyRegistered ms-auto noticeReplyRegistered">{{noticeReplyRegistered}}</span>
		</div>  
		<div class="card-body position-relative p-1 px-2">
			<div class="card-text p-1 px-3 gatherReplyDetail">{{noticeReplyDetail}}</div>
			<div class="floatRightTop position-absolute top-0 end-0 p-1">
				<button type="button" class="btn btn-sm btn-secondary p-1 me-1 edit-btn {{isWriter}}" data-noticereply-idx="{{noticeReplyIdx}}">수정</button>
				<button type="button" class="btn btn-sm btn-secondary p-1 me-1 remove-btn {{isWriter}}" data-noticereply-idx="{{noticeReplyIdx}}">삭제</button>
			</div>
		</div>
	</div>
</template>
<button class="btn btn-secondary more-btn">더보기</button> 
<button class="btn btn-secondary less-btn">접기</button>
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

<script>
	var page = 1;
	var size = 10;
	var noticeIdx= "${noticeIdx}";

	$(function(){ 
		$(".more-btn").click(function(){
			loadList(page,size,noticeIdx); 
			console.log(page); 
			page++;  
			console.log(page);   
		}); 
		//더보기 버튼을 강제 1회 클릭(트리거) 
		$(".more-btn").click();
		$(".less-btn").click(function(){
			$("#result").empty();  
			page=1;        
			loadList(page,size,noticeIdx);  
			page++; 
		});
	});


	$(function(){
		//처음 들어오면 목록 출력
		//#insert-form이 전송되면 전송 못하게 막고 ajax로 insert
	loadList(page,size,noticeIdx); 
		$("#insert-form").submit(function(e){
			e.stopImmediatePropagation();
			e.stopPropagation();
			e.preventDefault();
			e.cancelBubble = true;
			stopEvent(); 
			
			var dataValue = $(this).serialize();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/noticeData/replyInsert",
				type:"post",
				data : dataValue,
				//dataType 없음
				success:function(resp){
					console.log("성공", resp);
				
					//주의 : this 는 form이 아니다(this는 함수를 기준으로 계산)
					//jQuery는 reset() 명령이 없어서 get(0)으로 javascript 객체로 변경
					//$("#insert-form").get(0).reset();
					$("#insert-form")[0].reset();
					$("#result").empty();
					//성공하면 목록 갱신
					page =1; 
					loadList(page,size,noticeIdx);
					console.log("입력 들어옴");
					page++;
				},
				error:function(e){
					console.log("실패", e);
					console.log(dataValue);
				}
			});
		});
	});




	//댓글 목록 리스트
	function loadList(pageValue, sizeValue,noticeIdxValue){
		var gatherIdxValue = $("#noticeIdxValue").data("notice-idx");
		$.ajax({
			url:"${pageContext.request.contextPath}/noticeData/replyList",
			type:"get",
			data:{
				page:pageValue,
				size:sizeValue,
				noticeIdx:noticeIdxValue
			},
			dateType:"json",
			success:function(resp){
				if(resp.length < sizeValue && page==2){   
					//게시물이 10개 이하 일 떄 page=1일 떄
					$(".more-btn").hide();    
					$(".less-btn").hide();  
				}else if(resp.length <sizeValue && page>2){//게시물이 10개 이하 + page는 2번 
					$(".more-btn").hide(); 
					$(".less-btn").show();     
				}  
				else{ 
					$(".more-btn").show(); 
					$(".less-btn").hide();  
				} 
				
				
				for(var i=0; i<resp.length; i++){
					var template = $("#noticeVO-template").html();
					
					template = template.replace("{{noticeReplyIdx}}",resp[i].noticeReplyIdx);
					template = template.replace("{{noticeReplyIdx}}",resp[i].noticeReplyIdx);
					template = template.replace("{{noticeReplyIdx}}",resp[i].noticeReplyIdx);
					template = template.replace("{{memberNick}}",resp[i].memberNick);
					template = template.replace("{{noticeReplyDetail}}",resp[i].noticeReplyDetail);
					
 //					var time = resp[i].noticeReplyRegistered;
// 					var date =new Date(time);
					template = template.replace("{{noticeReplyRegistered}}",resp[i].noticeReplyRegistered);  
					var isWriter = resp[i].memberNick === '${sessionScope.memberNick}';
					var isWriter = resp[i].memberNick === '${sessionScope.memberNick}';
					var isWriterClass = !isWriter ? "d-none": "";
				
					template = template.replace("{{isWriter}}", isWriterClass); 
					template = template.replace("{{isWriter}}", isWriterClass);
					
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					
					console.log(tag.find(".remove-btn"));
					
					//댓글 삭제
					tag.find(".remove-btn").click(function(){
						console.log("누름");
						deleteReply($(this).data("noticereply-idx"));
					});
					 
					//댓글 수정 
					tag.find(".edit-btn").click(function(){   
						
						 $(this).parent().prevAll
						var noticeReplyIdx = $(this).data("noticereply-idx"); 
						var memberNick = $(this).parent().parent().prevAll(".memberNick").text();
						var noticeReplyDetail = $(this).parent().prevAll(".noticeReplyDetail").text();
						var noticeReplyDate = $(this).parent().prevAll(".noticeReplyRegistered").text();
						
						var form =$("<form>");
						   
						console.log(noticeReplyIdx);
						console.log(noticeReplyDetail);
						
						form.append("<input type='hidden' name='noticeReplyIdx' value='"+noticeReplyIdx+"'>");
						form.append("<input type='text' name='noticeReplyDetail' value='"+noticeReplyDetail+"'>");
						form.append("<button type='submit'>수정</button>");
				
						form.submit(function(e){
						e.preventDefault();
							
							
						var dataValue=$(this).serialize();			
						$.ajax({
							url:"${pageContext.request.contextPath}/noticeData/replyEdit",
							type:"post",
							data:dataValue,
							success:function(resp){
								$("#result").empty();
								page=1;
								loadList(page,size,noticeIdx);	
								console.log("편집 들어옴"); 
								page++;
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


	 
	<!-- 댓글삭제 -->
<script>
	function deleteReply(noticeReplyIdxValue){

		$.ajax({
//				url:"${pageContext.request.contextPath}/data/data8?examId="+examIdValue,
			url:"${pageContext.request.contextPath}/noticeData/replyDelete?"+$.param({"noticeReplyIdx":noticeReplyIdxValue}),
			type:"delete",
				data:{
					noticeReplyIdx : noticeReplyIdxValue
				},
			dataType:"text",
			success:function(resp){
				console.log("성공", resp);
				$("#result").empty();
				page=1;
				loadList(page,size,noticeIdx);			
				page++;
			},
			error:function(e){}
		});
	}
</script>
