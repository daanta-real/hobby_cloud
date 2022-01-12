<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 결제 상세조회</TITLE>
<style>
.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
}
 
.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}

</style>
<script type='text/javascript'>

//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
	//지도 생성 준비 코드
	var container = document.querySelector("#map");
	var options = {
		center : new kakao.maps.LatLng(
			$("input[name=lecLocLatitude]").val(),
			$("input[name=lecLocLongitude]").val()
		),
		level : 3
	};

	//지도 생성 코드
	var map = new kakao.maps.Map(container, options);

	// 마커가 표시될 위치입니다 
	var markerPosition = new kakao.maps.LatLng(
		$("input[name=lecLocLatitude]").val(),
		$("input[name=lecLocLongitude]").val()
	);

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		position : markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
});

</script>

<!-- 평점 등록 -->
<script>
$(function(){
	//처음 들어오면 목록 출력.
	loadReview();
	//#insert-form이 전송되면 전송 못하게 막고 ajax로 insert
	$("#insertReview-form").submit(function(e){
		console.log("누름");
		//this == #insert-form
		e.preventDefault();
		
		var dataValue =$(this).serialize();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/lecData/reviewInsert",
			type:"post",
			data : dataValue,
			//dataType 없음
			success:function(resp){
				console.log("성공", resp);
				$("#insertReview-form")[0].reset();
				
				//성공하면 목록 갱신
				loadReview();
			
			},
			error:function(e){
				console.log("실패", e);
				console.log(dataValue);
			}
		});
	});
});
</script>

<!-- 평점 조회 -->
<script>
function loadReview(){
	var lecIdxValue = $("#lecIdxValue").data("lec-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/lecData/reviewList",
		type:"get",
		data:{
			lecIdx:lecIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
			$("#resultReview").empty();//내부영역 청소
			//$("#result").html("");
			//$("#result").text("");
			
			for(var i=0; i < resp.length; i++){
				var template = $("#lecReviewVO-template").html();
				
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{memberNick}}", resp[i].memberNick);
				template = template.replace("{{lecReviewScore}}", resp[i].lecReviewScore);
				template = template.replace("{{lecIdx}}", resp[i].lecIdx);
				template = template.replace("{{lecReviewDetail}}", resp[i].lecReviewDetail);
				template = template.replace("{{lecReviewRegistered}}", resp[i].lecReviewRegistered);
		
				var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
	
				console.log(tag.find(".remove-btn"));
				
				//별점 삭제
				tag.find(".remove-btn").click(function(){
					console.log("누름");
					deleteReview($(this).data("lecreview-idx"));
				});
				
				//별점 수정
				tag.find(".edit-btn").click(function(){
					
					var lecReviewIdx = $(this).prevAll(".lecReviewIdx").text();
					var lecReviewDetail = $(this).prevAll(".lecReviewDetail").text();
					var lecReviewScore = $(this).prevAll(".lecReviewScore").text();
				
					var form = $("<form>");
					form.append("<input type='hidden' name='lecReviewIdx' value='"+lecReviewIdx+"'>");
					form.append("<input type='text' name='lecReviewDetail' value='"+lecReviewDetail+"'>");
					form.append("<div class='star-rating space-x-4 mx-auto'> <input type='radio' id='5-stars' name='lecReviewScore'value='5' v-model='ratings'/> <label for='5-stars' class='star pr-4'>★</label> <input type='radio' id='4-stars' name='lecReviewScore' value='4' v-model='ratings'/>   <label for='4-stars' class='star'>★</label>  <input type='radio' id='3-stars' name='lecReviewScore' value='3' v-model='ratings'/><label for='3-stars' class='star'>★</label><input type='radio' id='2-stars' name='lecReviewScore' value='2' v-model='ratings'/>    <label for='2-stars' class='star'>★</label> <input type='radio' id='1-star' name='lecReviewScore' value='1' v-model='ratings' /> <label for='1-star' class='star'>★</label>");
					form.append("</div>");
					form.append("<button type='submit'>수정</button>");
					
					form.submit(function(e){
					e.preventDefault();
						
					var dataValue = $(this).serialize();
					console.log(dataValue);
					
					$.ajax({
						url:"${pageContext.request.contextPath}/lecData/reviewEdit",
						type:"post",
						data:dataValue,
						success:function(resp){
							console.log("성공", resp);
						
							$("#result").empty();
							
							loadReview();
						},
						error:function(e){}
					});
				});	
				
				var div = $(this).parent();
				div.html(form);
				
			});
		
				$("#resultReview").append(tag);
			}
		},
		error:function(e){
			console.log("실패",e);
		}
	});
}


//리뷰 삭제
function deleteReview(lecReviewIdxValue){

	$.ajax({
//			url:"${pageContext.request.contextPath}/data/data8?examId="+examIdValue,
		url:"${pageContext.request.contextPath}/lecData/reviewDelete?"+$.param({"lecReviewIdx":lecReviewIdxValue}),
		type:"delete",
			data:{
				lecReviewIdx : lecReviewIdxValue
			},
		dataType:"text",
		success:function(resp){
			console.log("성공", resp);
			
			loadReview();//데이터가 변하면 무조건 갱신
		},
		error:function(e){}
	});
}
</script>
<!-- 좋아요 -->
<script>
 $(function(){
 	$('#like-btn').click(function(){
 		likeUpdate();
 	});
	
 	function likeUpdate(){
//  		memberIdx = $('#memberIdx').val(),
 		lecIdx = $('#lecIdx').val(),
 		count = $('#like-check').val(),
 		data = {
//  			"memberIdx" : memberIdx,
 				"lecIdx" : lecIdx,
 				"count" : count};
		
 	$.ajax({
 		url : "${pageContext.request.contextPath}/lecData/likeUpdate",
 		type : 'POST',
 		contentType: 'application/json',
 		data : JSON.stringify(data),
 		success : function(result){
 			console.log("수정" + result.like);
 			if(count == 1){
 				console.log("좋아요 취소");
 				 $('#like-check').val(0);
 				 $('#like-btn').attr('class','btn btn-light');
 				 $('#likecount').html(result.like);
 			}else if(count == 0){
 				console.log("좋아요!");
 				$('#like-check').val(1);
 				$('#like-btn').attr('class','btn btn-danger');
 				$('#likecount').html(result.like);
 			}
 		}, error : function(result){
 			console.log("에러" + result.result)
 		}
 		});
 	};
 });
</script>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />


<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">


<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			${lecDetailVO.lecName}
			</span>
		</div>
		<div id="lecIdxValue" data-lec-idx="${lecDetailVO.lecIdx}"></div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
	<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 정보</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<table border="1" width="80%">
				 <tbody>
			     <tr>
			         <td>카테고리</td>
			         <td>${lecDetailVO.lecCategoryName}</td>
			         <td>지역</td>
			         <td>${lecDetailVO.placeName}</td>
			     </tr>
			     <tr>
			         <td>강사명</td>
			         <td>${lecDetailVO.memberNick}</td>
			         <td>수강인원</td>
			         <td>${lecDetailVO.lecHeadCount} 명</td>
			     </tr>
			     <tr>
			         <td>기간</td>
			         <td>${lecDetailVO.lecStart} ~ ${lecDetailVO.lecEnd}</td>
			         <td>수강료</td>
			         <td>${lecDetailVO.lecPrice}</td>
			     </tr>
			 	 </tbody>
			</table>
		</div>
		<!-- 소단원 제목 -->
<!-- 		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 정보</div> -->
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<c:choose>
				<c:when test="${memberIdx != null}">
					<div id="like">
						<c:choose>
							<c:when test="${isLike == 0}">
								<button type="button" class="btn btn-light" id="like-btn">🤍 ${lecDetailVO.lecLike}</button>
								<input type="hidden" id="like-check" value="${isLike}">
					<%-- 			<input type="hidden" id="memberIdx" value="${memberIdx}"> --%>
								<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
							</c:when>					
							<c:when test="${isLike == 1}">
								<button type="button" class="btn btn-light" id="like-btn">❤️ ${lecDetailVO.lecLike}</button>
								<input type="hidden" id="like-check" value="${isLike}">
					<%-- 			<input type="hidden" id="memberIdx" value="${memberIdx}"> --%>
								<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
							</c:when>			
						</c:choose>
					</div>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/member/login" class="btn btn-danger">좋아요</a>
				</c:otherwise>
			</c:choose>
			
			<!-- 찜하기 -->
			<form name="form1" method="post"
			 action="${pageContext.request.contextPath}/lec/cart/insert">
			    <input type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
			    <input type="submit" class="btn btn-danger" value="찜하기">
			</form>
			
			<!-- 강좌 추가하기 -->
			<a href="${pageContext.request.contextPath}/lec/check/${lecDetailVO.lecIdx}" class="btn btn-danger">강좌 신청</a>
		</div>
		
		
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 상세</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<c:choose>
				<c:when test="${list == null}">
				<img src="https://via.placeholder.com/300x500?text=User" width="50%" class="image">
				</c:when>
				<c:otherwise>
				<c:forEach var="LecFileDto" items="${list}"> 
					<img src="${pageContext.request.contextPath}/lec/lecFile/${LecFileDto.lecFileIdx}" width="50%" 
					class="image image-round image-border">
				</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		
		
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>장소 정보</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<!--상세페이지 지도 -->
			<input type="hidden" name="lecLocLongitude" value="${lecDetailVO.lecLocLongitude}">
			<input type="hidden" name="lecLocLatitude"  value="${lecDetailVO.lecLocLatitude}">
			<div id="map" style="width:50%;height:350px;"></div>
			<table border="1" width="80%">
				 <tbody>
				     <tr>
				         <td>지역</td>
				         <td>${lecDetailVO.placeName}</td>
				     </tr>
				     <tr>
				         <td>지역 상세</td>
				         <td>${lecDetailVO.placeDetail}</td>
				     </tr>
				     <tr>
				         <td>강좌 지역 정보</td>
				         <td>${lecDetailVO.lecLocRegion}</td>
				     </tr>
				 </tbody>
			</table>
		</div>
		
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강사 정보</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<table border="1" width="80%">
		 	<tbody>
			    <tr>
			        <td>강사 등록일</td>
			        <td>${lecDetailVO.tutorRegistered}</td>
			   	</tr>
			    <tr>
			        <td>강사 이름</td>
			        <td>${lecDetailVO.memberNick}</td>
			    </tr>
			    <tr>
			        <td>강사 이메일</td>
			        <td>${lecDetailVO.memberEmail}</td>
			    </tr>
			    <tr>
			    	<td>강사 번호</td>
			        <td>${lecDetailVO.memberPhone}</td>
			    </tr>
			</tbody>
			</table>
		</div>
		
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>평점</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<!-- 평점 -->
			<form id="insertReview-form">
			<div class="card mb-2 border border-1 border-secondary p-0">
			<div class="card-header d-flex align-items-center p-1 px-2">
				<span>평점을 입력해주세요</span>
			</div>
			<div class="card-body position-relative p-1 px-2"> 
			
			 	<div class="star-rating space-x-4 mx-auto"> 
			        <input type="radio" id="5-stars" name="lecReviewScore" value="5" v-model="ratings"/>
			        <label for="5-stars" class="star pr-4">★</label>
			        <input type="radio" id="4-stars" name="lecReviewScore" value="4" v-model="ratings"/>
			        <label for="4-stars" class="star">★</label>
			        <input type="radio" id="3-stars" name="lecReviewScore" value="3" v-model="ratings"/>
			        <label for="3-stars" class="star">★</label>
			        <input type="radio" id="2-stars" name="lecReviewScore" value="2" v-model="ratings"/>
			        <label for="2-stars" class="star">★</label>
			        <input type="radio" id="1-star" name="lecReviewScore" value="1" v-model="ratings" />
			        <label for="1-star" class="star">★</label>
			    </div> 
			    
				<input type="text" name="lecReviewDetail">
				<input	type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
				<button type="submit" class="btn btn-sm btn-secondary p-1 me-1">등록</button> 
			</div>
			</div>
			</form>
			<div id="resultReview"></div>  
			
			<!-- 평점목록 -->
			<template id="lecReviewVO-template">
			<div class="card mb-2 border border-1 border-secondary p-0 item">
				<div class="card-header d-flex align-items-center p-1 px-2">
					<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
					<span class="memberNick">{{memberNick}}</span> 
					<span class="lecReviewScore">점수:{{lecReviewScore}}</span> 
					<span class="memberReviewRegistered ms-auto lecReviewRegistered">{{lecReviewRegistered}}</span>
				</div>
				<div class="card-body position-relative p-1 px-2">
				<div class="card-text p-1 px-3 lecReviewDetail">{{lecReviewDetail}}</div>	
					<div class="floatRightTop position-absolute top-0 end-0 p-1">
						<button type="button" class="btn btn-sm btn-secondary p-1 me-1 edit-btn" data-lecreview-idx="{{lecReviewIdx}}">수정</button>
					 	<button type="button" class="btn btn-sm btn-secondary p-1 me-1 remove-btn" data-lecreview-idx="{{lecReviewIdx}}">삭제</button>
				 	</div>
				</div>
			</div>
			</template>
			
			<div id="resultReview"></div> 
		</div>
		
		<nav class="row pt-4 d-flex flex-justify-between">
			<a href="insert">글쓰기</a>
		</nav>
		<nav class="row pt-4 d-flex flex-justify-between">
			<a href="${pageContext.request.contextPath}/lec/list">목록보기</a>
		</nav>
		<nav class="row pt-4 d-flex flex-justify-between">
			<a href="${pageContext.request.contextPath}/lec/edit/${lecDetailVO.lecIdx}">수정</a>			
		</nav>
		<nav class="row pt-4 d-flex flex-justify-between">
			<a href="${pageContext.request.contextPath}/lec/delete/${lecDetailVO.lecIdx}">삭제</a>	
		</nav>
	</SECTION>
	<!-- 페이지 내용 끝. -->




<!-- 댓글 -->
<!-- 댓글 목록 -->
<!-- <template id="lecReplyVO-template"> -->
<!-- <div class="item"> -->
<!-- <span class="lecReplyIdx">{{lecReplyIdx}}</span> -->
<!-- <span class="memberNick">{{memberNick}}</span> -->
<!-- <span class="lecReplyDetail">{{lecReplyDetail}}</span> -->
<!-- <span class="lecReplyRegistered">{{lecReplyRegistered}}</span> -->
<!-- <button class="edit-btn" data-lecReplyIdx="{{lecReplyIdx}}">수정</button> -->
<!-- <button class="remove-btn" data-lecReplyIdx="{{lecReplyIdx}}">삭제</button> -->
<!-- </div> -->
<!-- </template> -->

<!-- <div id="result"></div> -->

</ARTICLE>
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->


<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>
