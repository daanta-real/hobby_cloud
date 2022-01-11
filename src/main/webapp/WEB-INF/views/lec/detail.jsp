<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
       src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services"></script>
   
   
<script>
   $(function() {
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
    
    
<h2 id="lecIdxValue" data-lec-idx="${lecDetailVO.lecIdx}">${lecDetailVO.lecName} 강좌 상세 </h2>

<br>

<h2>강좌정보</h2>
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

<div>좋아요 개수 : ${lecDetailVO.lecLike}</div>
<c:choose>
	<c:when test="${memberIdx != null}">
		<div id="like">
			<c:choose>
				<c:when test="${isLike == 0}">
					<button type="button" class="btn btn-light" id="like-btn">좋아요</button>
					<input type="hidden" id="like-check" value="${isLike}">
		<%-- 			<input type="hidden" id="memberIdx" value="${memberIdx}"> --%>
					<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
				</c:when>					
				<c:when test="${isLike == 1}">
					<button type="button" class="btn btn-danger" id="like-btn">좋아요</button>
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
    <input type="hidden" name="lecIdx"
     value="${lecDetailVO.lecIdx}">
    <input type="submit" class="btn btn-light" value="찜하기">
</form>

<!-- 강좌 추가하기 -->
<a href="${pageContext.request.contextPath}/lec/check/${lecDetailVO.lecIdx}" class="btn btn-danger">강좌 신청</a>
<br>

<h2>강좌 상세</h2>
<div class="row">
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

<h2>장소 정보</h2>
<!-- 여기에 장소 표시할 지도 들어갈거임 -->
<!--상세페이지 지도 -->
<input type="text" name="lecLocLongitude" value="${lecDetailVO.lecLocLongitude}">
<input type="text" name="lecLocLatitude"  value="${lecDetailVO.lecLocLatitude}">
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
	         <td>카카오에서 선택한 지역</td>
	         <td>${lecDetailVO.lecLocRegion}</td>
	     </tr>
	     <tr>
	         <td>카카오에서 선택한 위도</td>
	         <td>${lecDetailVO.lecLocLatitude}</td>
	     </tr>
	     <tr>
	         <td>카카오에서 선택한 경도</td>
	         <td>${lecDetailVO.lecLocLongitude}</td>
	     </tr>
	 </tbody>
</table>

<br>

<h2>강사 정보</h2>

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

<hr>
<!-- 댓글 -->
<!-- 댓글 목록 -->
<template id="lecReplyVO-template">
<div class="item">
<span class="lecReplyIdx">{{lecReplyIdx}}</span>
<span class="memberNick">{{memberNick}}</span>
<span class="lecReplyDetail">{{lecReplyDetail}}</span>
<span class="lecReplyRegistered">{{lecReplyRegistered}}</span>
<button class="edit-btn" data-lecReplyIdx="{{lecReplyIdx}}">수정</button>
<button class="remove-btn" data-lecReplyIdx="{{lecReplyIdx}}">삭제</button>
</div>
</template>

<div id="result"></div>

<!-- 평점 -->
<input type="radio" id="5-stars" name="lecReviewScore" value="5" v-model="ratings"/>
<form id="insertReview-form">
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
	내용 : <input type="text" name="lecReviewDetail">
	<input	type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
		 <input	type="submit" value="전송하기">
</form>

<!-- 평점목록 -->
<template id="lecReviewVO-template">
<div class="item">
	<span class="lecReviewIdx">{{lecReviewIdx}}</span> 
	<span	class="memberNick">{{memberNick}}</span> 
	<span class="lecIdx">{{lecIdx}}</span>
	<span class="lecReviewScore">{{lecReviewScore}}</span> 
	<span	class="lecReviewDetail">{{lecReviewDetail}}</span>
	<button class="edit-btn" data-lecreview-idx="{{lecReviewIdx}}">수정</button>
	<button class="remove-btn" data-lecreview-idx="{{lecReviewIdx}}">삭제</button>
</div>
</template>

<div id="resultReview"></div> 


<a href="insert">글쓰기</a>
<a href="${pageContext.request.contextPath}/lec/list">목록보기</a>
<a href="${pageContext.request.contextPath}/lec/edit/${lecDetailVO.lecIdx}">수정</a>			
<a href="${pageContext.request.contextPath}/lec/delete/${lecDetailVO.lecIdx}">삭제</a>	


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
