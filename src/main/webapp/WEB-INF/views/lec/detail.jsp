<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="isLogin" value="${memberIdx != null}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 결제 상세조회</TITLE>
<style>
#like-btn, #jjim-btn { width:6rem; }

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
var pageR = 1;
var sizeR = 10;
$(function(){ 
	$(".moreR-btn").click(function(){
		loadReview(pageR,sizeR,lecIdx); 
		pageR++;    
	});  
	//더보기 버튼을 강제 1회 클릭(트리거) 
	$(".moreR-btn").click(); 
	
	$(".lessR-btn").click(function(){
		$("#resultReview").empty(); 
		pageR=1;       
		loadReview(pageR,sizeR,lecIdx); 
		pageR++; 
	});
}); 

$(function(){
	//처음 들어오면 목록 출력.
// 	loadReview();
	//#insert-form이 전송되면 전송 못하게 막고 ajax로 insert
	$("#insertReview-form").submit(function(e){
		e.stopImmediatePropagation();
		e.stopPropagation();
		e.preventDefault();
		e.cancelBubble = true;
		stopEvent();
		
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
				$("#resultReview").empty();
				pageR=1;
				loadReview(pageR,sizeR,lecIdx);
				pageR++;
			
			},
			error:function(e){
				console.log("실패", e);
				console.log(dataValue);
			}
		});
	});
});
</script>

<script>
function dateFormat(date) {
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute; 
}
</script>

<!-- 평점 조회 -->
<script>
function loadReview(pageRValue,sizeRValue,lecIdxValue){
	var lecIdxValue = $("#lecIdxValue").data("lec-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/lecData/reviewList",
		type:"get",
		data:{
			pageR:pageRValue,
			sizeR:sizeRValue,
			lecIdx:lecIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
// 			$("#resultReview").empty();//내부영역 청소
// 			//$("#result").html("");
// 			//$("#result").text("");
			if(resp.length < sizeRValue && pageR==2){   
				//게시물이 10개 이하 일 떄 page=1일 떄
				$(".moreR-btn").hide();   
				$(".lessR-btn").hide();  
			}else if(resp.length <sizeRValue && pageR>2){//게시물이 10개 이하 + page는 2번 
				$(".moreR-btn").hide(); 
				$(".lessR-btn").show();     
			}  
			else{ 
				$(".moreR-btn").show();
				$(".lessR-btn").hide();  
			} 
			
			for(var i=0; i < resp.length; i++){
				var template = $("#lecReviewVO-template").html();
				template = template.replace("{{memberIdx}}", resp[i].memberIdx);   
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{lecReviewIdx}}", resp[i].lecReviewIdx);
				template = template.replace("{{memberNick}}", resp[i].memberNick);
				template = template.replace("{{lecReviewScore}}", resp[i].lecReviewScore);
				template = template.replace("{{lecIdx}}", resp[i].lecIdx);
				template = template.replace("{{lecReviewDetail}}", resp[i].lecReviewDetail);
				
				var time = resp[i].lecReviewRegistered;
				var date =new Date(time);
				template = template.replace("{{lecReviewRegistered}}", dateFormat(date));
			
				var isWriter = resp[i].memberNick === '${sessionScope.memberNick}';
				var isWriter = resp[i].memberNick === '${sessionScope.memberNick}';
				var isWriterClass = !isWriter ? "d-none": "";
			
				template = template.replace("{{isWriter}}", isWriterClass); 
				template = template.replace("{{isWriter}}", isWriterClass); 
				
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
						
							$("#resultReview").empty();
							pageR=1;
							loadReview(pageR,sizeR,lecIdx);
							pageR++;
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
			$("#resultReview").empty();
			
			pageR=1;
			loadReview(pageR,sizeR,lecIdx);
			pageR++; 
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
 				"count" : count
 				};

 	$.ajax({
 		url : "${pageContext.request.contextPath}/lecData/likeUpdate",
 		type : 'POST',
 		contentType: 'application/json',
 		data : JSON.stringify(data),
 		success : function(result){
 			console.log("수정" + result.like);
 			if(count == 1){
 				// 좋아요를 뺐을 때
 				 $('#like-check').val(0);
 				 document.getElementById('like-btn').classList.remove('btn-primary');
 				 document.getElementById('like-btn').classList.add('btn-light');
 				 document.getElementById('like-btn').classList.remove('text-light');
 				 document.getElementById('like-btn').classList.add('text-primary');
 				document.getElementById('like-btn').innerHTML = "♥ " + result.like;
 				 $('#likecount').text(result.like);
 			}else if(count == 0){
 				// 좋아요를 눌렀을 때
 				console.log("좋아요!");
 				$('#like-check').val(1);
 				 document.getElementById('like-btn').classList.remove('btn-light');
				 document.getElementById('like-btn').classList.add('btn-primary');
 				 document.getElementById('like-btn').classList.remove('text-primary');
 				 document.getElementById('like-btn').classList.add('text-light');
  				document.getElementById('like-btn').innerHTML = "♥ " + result.like;
 				document.getElementById('like-btn')
 				$('#likecount').text(result.like);
 			}
 		}, error : function(result){
 			console.log("에러" + result.result)
 		}
 		});
 	};
 });
</script>
<script>
$(function(){
	var msg = "${msg}";
	console.log(msg);
	if(msg.length > 0){
		alert(msg);
	}
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
			         <td>${getNowCount} / ${lecDetailVO.lecHeadCount} 명</td>
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
			<div class="container">
				<div class="row md-4 d-flex justify-content-between">
					<c:choose>
						<c:when test="${memberIdx != null}">
							<div id="like" class="col-6 p-0">
								<c:choose>
									<c:when test="${isLike == 0}">
										<button type="button" class="col-auto btn text-primary btn-light btn-outline-primary" id="like-btn">♥ ${lecDetailVO.lecLike}</button>
										<input type="hidden" id="like-check" value="${isLike}">
							<%-- 			<input type="hidden" id="memberIdx" value="${memberIdx}"> --%>
										<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
									</c:when>					
									<c:when test="${isLike == 1}">
										<button type="button" class="col-auto btn text-light btn-primary btn-outline-primary" id="like-btn">♥ ${lecDetailVO.lecLike}</button>
										<input type="hidden" id="like-check" value="${isLike}">
							<%-- 			<input type="hidden" id="memberIdx" value="${memberIdx}"> --%>
										<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
									</c:when>			
								</c:choose>
							</div>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/member/login" class="col-auto btn btn-outline-primary mx-1">❤️ ${lecDetailVO.lecLike}</a>
						</c:otherwise>
					</c:choose>
				
				<!-- 찜하기 -->
					<form name="form1" method="post" class="col-6 d-flex justify-content-end p-0"
					 action="${pageContext.request.contextPath}/lec/cart/insert">
					    <input type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
					    <input type="submit" id="jjim-btn" class="btn btn-outline-primary" value="찜하기">
					</form>
				</div>
				
				<!-- 강좌 추가하기 -->
<%-- 				${getNowCount < lecDetailVO.lecHeadCount} --%>
<%-- 				${lecDetailVO.lecHeadCount} --%>
<%-- 				${getNowCount} --%>
				<div class="row md-4">
					<c:choose>
						<c:when test="${getNowCount < lecDetailVO.lecHeadCount}">
							<a href="${pageContext.request.contextPath}/my/lec/confirm/${lecDetailVO.lecIdx}" class="btn btn-danger text-light">강좌 신청</a>
						</c:when>
						<c:otherwise>
							<span class="btn btn-secondary text-light">강좌 신청 불가</span>
						</c:otherwise>
					</c:choose>
				</div>
				
			</div>
		</div>
		
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 상세</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="row md-4">${lecDetailVO.lecDetail}</div>
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
<!-- 				     <tr> -->
<!-- 				         <td>지역</td> -->
<%-- 				         <td>${lecDetailVO.placeName}</td> --%>
<!-- 				     </tr> -->
<!-- 				     <tr> -->
<!-- 				         <td>지역 상세</td> -->
<%-- 				         <td>${lecDetailVO.placeDetail}</td> --%>
<!-- 				     </tr> -->
				     <tr>
				         <td>강좌 장소 정보</td>
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
			        <td>강사 프로필</td>
					<c:choose>
						<c:when test="${GatherHeadsVO.memberProfileIdx != 0 }">  			
							<td class="text-center align-middle text-nowrap">
								<img src="${pageContext.request.contextPath}/member/profile/${lecDetailVO.memberIdx}" width="10%" />
							</td>  
						</c:when>
						<c:otherwise>
							<td class="text-center align-middle text-nowrap">
								<img src="${pageContext.request.contextPath}/resources/img/noImage.png" width="10%">
							</td>
						</c:otherwise>
					</c:choose>					
			   	</tr>
			    <tr>
			        <td>강사 이름</td>
			        <td>${lecDetailVO.memberNick}</td>
			    </tr>
			    <tr>
			        <td>강사 소개</td>
			        <td>${lecDetailVO.tutorDetail}</td>
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
			<div class="container"></div>
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
				    
					<input type="text" name="lecReviewDetail" placeholder="로그인을 해주세요">
					<input	type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
					<c:if test="${isLogin}">
						<button type="submit" class="btn btn-sm btn-secondary p-1 me-1">평점 등록</button> 
					</c:if>				
				</div>
				</div>
				</form>
				<div id="resultReview"></div>  
				</div>
				
				<!-- 평점목록 -->
				<template id="lecReviewVO-template">
				<div class="card mb-2 border border-1 border-secondary p-0 item">
					<div class="card-header d-flex align-items-center p-1 px-2">
						<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" 
						src="${root}/member/profile/{{memberIdx}}"
						style="width:2.3rem; height:2.3rem;"/>
						<span class="memberNick">닉네임 : {{memberNick}}</span> 
						<span class="lecReviewScore">점수 : {{lecReviewScore}}</span> 
						<span class="memberReviewRegistered ms-auto lecReviewRegistered">{{lecReviewRegistered}}</span>
					</div>
					<div class="card-body position-relative p-1 px-2">
						<div class="card-text p-1 px-3 lecReviewDetail">{{lecReviewDetail}}</div>	
						<div class="floatRightTop position-absolute top-0 end-0 p-1">
						 	<button type="button" class="btn btn-sm btn-secondary p-1 me-1 remove-btn {{isWriter}}" data-lecreview-idx="{{lecReviewIdx}}">삭제</button>
					 	</div>
					</div>
				</div>
				</template>
				
				<div class="row mb-4">
					<button class="btn btn-secondary moreR-btn">더보기</button> 
					<button class="btn btn-secondary lessR-btn">접기</button>
				</div>
		
				<div class="row mb-4 container">
					<nav class="row pt-4 d-flex flex-row flex-justify-between">
						<div class="col-sm-6 col-md-3 px-3 d-flex justify-content-center"><a class="btn btn-primary text-light text-center" href="${pageContext.request.contextPath}/lec/register">글쓰기</a></div>
						<div class="col-sm-6 col-md-3 px-3 d-flex justify-content-center"><a class="btn btn-primary text-light text-center" href="${pageContext.request.contextPath}/lec/list">목록보기</a></div>
						<div class="col-sm-6 col-md-3 px-3 d-flex justify-content-center"><a class="btn btn-primary text-light text-center" href="${pageContext.request.contextPath}/lec/edit/${lecDetailVO.lecIdx}">수정</a></div>	
						<div class="col-sm-6 col-md-3 px-3 d-flex justify-content-center"><a class="btn btn-primary text-light text-center" href="${pageContext.request.contextPath}/lec/delete/${lecDetailVO.lecIdx}">삭제</a>	</div>
					</nav>
				</div>
				
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
