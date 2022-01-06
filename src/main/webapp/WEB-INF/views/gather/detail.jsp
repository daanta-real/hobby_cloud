<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services"></script>
    
    
    <script>
    $(function() {
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center : new kakao.maps.LatLng($("input[name=gatherLocLongitude]").val(), $(
					"input[name=gatherLocLatitude]").val()),
			level : 3
		};

		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng($("input[name=gatherLocLongitude]")
				.val(), $("input[name=gatherLocLatitude]").val());

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	});
    </script>
<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet"
	href="https://bootswatch.com/5/journal/bootstrap.css">
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


<!-- Bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">
<!-- JQuery 3.6.0 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- XE Icon -->
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>


<c:set var="isLogin" value="${memberIdx != null}" />


<h2 id="gatherIdxValue" data-gather-idx="${GatherVO.gatherIdx}">${GatherVO.gatherIdx}번게시글</h2>
<input type="text" name="gatherLocLongitude" value="${GatherVO.gatherLocLongitude}">
<input type="text" name="gatherLocLatitude"  value="${GatherVO.gatherLocLatitude}">

<!--상세페이지 지도 -->
<div id="map" style="width:50%;height:350px;"></div>
 
<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${GatherVO.gatherName}</h3>
			</td>
		</tr>
		<tr>
			<td>작성자 :${GatherVO.memberNick} | 장소 :
				${GatherVO.gatherLocRegion}</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td class="participate"><pre>${GatherVO.gatherDetail}</pre> 
			
			
			
			<c:set	var="isJoin" value="false" /> <c:set var="isFull" value="false" />
				
				
				<!-- 참가자 리스트 반복문 -->
				 <c:forEach var="GatherHeadsVO" items="${list2}"
					varStatus="status">
					<c:out value="${status.count}" />

					<!-- 참가자 인원을 확인 -->
					<c:if test="${status.count ==1 }">
						<c:set var="isFull" value="true" />
					</c:if>



					<!-- 참가여부를 확인 -->
					<c:if test="${GatherHeadsVO.memberIdx  eq memberIdx}">
						<!-- 만약에 일치한다  -->
						<c:set var="isJoin" value="true" />
					</c:if>

	<div id="map" style="width: 100%; height: 50px; border-radius: 50px;"></div>  

					<tr>
						<th>닉네임</th>
						<th>프로필</th>
					</tr>
					<tr>
						<td>${GatherHeadsVO.memberNick}</td>
						<td>${GatherHeadsVO.gatherIdx}</td>
					</tr>
				</c:forEach> 
				
				<c:choose>
					<c:when test="${isFull}">
					</c:when>
				</c:choose> <!-- 게시판 사진 반복문 --> <c:forEach var="GatherFileDto" items="${list}">
					<span><${GatherFileDto.gatherFileUserName}</span>
					<br>
					<img
						src="${pageContext.request.contextPath}/gather/file/${GatherFileDto.gatherFileIdx}"
						width="30%" class="image image-round image-border">
				</c:forEach></td>



		</tr>
		<!-- 소모임 참가 /취소 버튼 -->
		<tr>
			<td>
				<!-- 참가하기 버튼 --> <c:choose>
					<c:when test="${isJoin}">
						<a class="btn btn-warning"
							href="${pageContext.request.contextPath}/gather/cancel?gatherIdx=${GatherVO.gatherIdx}">취소하기</a>
					</c:when>
					<c:when test="${isFull}">
						<a class="btn btn-secondary"
							href="${pageContext.request.contextPath}/gather/cancel?gatherIdx=${GatherVO.gatherIdx}">완료</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-primary"
							href="${pageContext.request.contextPath}/gather/join?gatherIdx=${GatherVO.gatherIdx}">참가하기</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td><a href="${pageContext.request.contextPath}/gather/insert">글쓰기</a>
				<a href="${pageContext.request.contextPath}/gather/list">목록보기</a> <a
				href="${pageContext.request.contextPath}/gather/update/${GatherVO.gatherIdx}">수정</a>
				<a
				href="${pageContext.request.contextPath}/gather/delete?gatherIdx=${GatherVO.gatherIdx}">삭제</a>

			</td>
		</tr>
	</tbody>
</table>

<!-- 게시판 댓글 작성 -->
<h1>댓글</h1>

<form id="insert-form">
	내용 : <input type="text" name="gatherReplyDetail"> <br> 
	<input	type="hidden" name="gatherIdx" value="${GatherVO.gatherIdx}">
	<input type="hidden" name="memberIdx" value="1">
	<button type="submit">등록</button>
</form>


<!-- 게시판 댓글 목록 -->
<template id="gatherVO-template">
<div class="item">
	<span class="gatherReplyIdx">{{gatherReplyIdx}}</span> <span
		class="memberNick">{{memberNick}}</span> <span
		class="gatherReplyDetail">{{gatherReplyDetail}}</span> <span
		class="gatherReplyDate">{{gatherReplyDate}}</span>
	<button class="edit-btn" data-gatherreply-idx="{{gatherReplyIdx}}">수정</button>
	<button class="remove-btn" data-gatherreply-idx="{{gatherReplyIdx}}">삭제</button>
</div>
</template>

<div id="result"></div>

<input type="radio" id="5-stars" name="gatherReviewScore" value="5" v-model="ratings"/>
<form id="insertReview-form">
 	<div class="star-rating space-x-4 mx-auto"> 
        <input type="radio" id="5-stars" name="gatherReviewScore" value="5" v-model="ratings"/>
        <label for="5-stars" class="star pr-4">★</label>
        <input type="radio" id="4-stars" name="gatherReviewScore" value="4" v-model="ratings"/>
        <label for="4-stars" class="star">★</label>
        <input type="radio" id="3-stars" name="gatherReviewScore" value="3" v-model="ratings"/>
        <label for="3-stars" class="star">★</label>
        <input type="radio" id="2-stars" name="gatherReviewScore" value="2" v-model="ratings"/>
        <label for="2-stars" class="star">★</label>
        
        <input type="radio" id="1-star" name="gatherReviewScore" value="1" v-model="ratings" />
        <label for="1-star" class="star">★</label>
     </div>  
	내용 : <input type="text" name="gatherReviewDetail">
		 <input type="hidden" name="gatherIdx" value="${GatherVO.gatherIdx}"> 
		 <input	type="submit" value="전송하기">
</form>

<!-- 평점목록 -->
<template id="gatherReviewVO-template">
<div class="item">
	<span class="gatherReviewIdx">{{gatherReviewIdx}}</span> 
	<span	class="memberNick">{{memberNick}}</span> 
	<span class="gatherIdx">{{gatherIdx}}</span>
	<span class="gatherReviewScore">{{gatherReviewScore}}</span> 
	<span	class="gatherReviewDetail">{{gatherReviewDetail}}</span>
	<button class="edit-btn" data-gatherreview-idx="{{gatherReviewIdx}}">e</button>
	<button class="remove-btn" data-gatherreview-idx="{{gatherReviewIdx}}">엑스</button>
</div>
</template>

<div id="resultReivew"></div>


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
			url:"${pageContext.request.contextPath}/gatherData/reviewInsert",
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
	var gatherIdxValue = $("#gatherIdxValue").data("gather-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/gatherData/reviewList",
		type:"get",
		data:{
			gatherIdx:gatherIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
			$("#resultReivew").empty();//내부영역 청소
			//$("#result").html("");
			//$("#result").text("");
			
			for(var i=0; i < resp.length; i++){
				var template = $("#gatherReviewVO-template").html();
				
				template = template.replace("{{gatherReviewIdx}}", resp[i].gatherReviewIdx);
				template = template.replace("{{gatherReviewIdx}}", resp[i].gatherReviewIdx);
				template = template.replace("{{gatherReviewIdx}}", resp[i].gatherReviewIdx);
				template = template.replace("{{memberNick}}", resp[i].memberNick);
				template = template.replace("{{gatherReviewScore}}", resp[i].gatherReviewScore);
				template = template.replace("{{gatherIdx}}", resp[i].gatherIdx);
				template = template.replace("{{gatherReviewDetail}}", resp[i].gatherReviewDetail);
		
				var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
	
				console.log(tag.find(".remove-btn"));
				
				//별점 삭제
				tag.find(".remove-btn").click(function(){
					console.log("누름");
					deleteReview($(this).data("gatherreview-idx"));
				});
				
				//별점 수정
				tag.find(".edit-btn").click(function(){
					
					var gatherReviewIdx = $(this).prevAll("gatherReviewIdx").text();
					var gatherReviewDetail = $(this).prevAll(".gatherReviewDetail").text();
					var gatherReviewScore = $(this).prevAll(".gatherReviewScore").text();
				
					var form = $("<form>");
					form.append("<input type='hidden' name='gatherReviewIdx' value='"+gatherReviewIdx+"'>");
					form.append("<input type='text' name='gatherReviewDetail' value='"+gatherReviewDetail+"'>");
					form.append("<div class='star-rating space-x-4 mx-auto'> <input type='radio' id='5-stars' name='gatherReviewScore'value='5' v-model='ratings'/> <label for='5-stars' class='star pr-4'>★</label>");
					
					form.append("<input type='radio' id='5-stars' name='gatherReviewScore'value='5' v-model='ratings'/>");
					form.append("<label for='5-stars' class='star pr-4'>★</label>");
					
					form.append("<input type='radio' id='4-stars' name='gatherReviewScore'value='4' v-model='ratings'/>");
					form.append("<label for='4-stars' class='star'>★</label>");
					
					form.append("<input type='radio' id='3-stars' name='gatherReviewScore' value='3' v-model='ratings'/>");
					form.append("<label for='3-stars' class='star'>★</label>");
					
					form.append("<input type='radio' id='2-stars' name='gatherReviewScore'value='2' v-model='ratings'/>");
					form.append("<label for='2-stars' class='star'>★</label>");
					
					form.append("<input type='radio' id='1-stars' name='gatherReviewScore'value='1' v-model='ratings'/>");
					form.append("<label for='1-stars' class='star'>★</label>");
				
					form.append("</div>");
					form.append("<button type='submit'>수정</button>");
					
					form.submit(function(e){
					e.preventDefault();
						
					var dataValue = $(this).serialize();
					console.log(dataValue);
					$.ajax({
						url:"${pageContext.request.contextPath}/snsReply/edit",
						type:"post",
						data:dataValue,
						success:function(resp){
							console.log("성공", resp);
						
							$("#result").empty();
							
		
						},
						error:function(e){}
					});
				});	
				
				var div = $(this).parent();
				div.html(form);
				
			});
		
				$("#resultReivew").append(tag);
			}
		},
		error:function(e){
			console.log("실패",e);
		}
	});
}


//리뷰 삭제
function deleteReview(gatherReviewIdxValue){

	$.ajax({
//			url:"${pageContext.request.contextPath}/data/data8?examId="+examIdValue,
		url:"${pageContext.request.contextPath}/gatherData/reviewDelete?"+$.param({"gatherReviewIdx":gatherReviewIdxValue}),
		type:"delete",
			data:{
				gatherReviewIdx : gatherReviewIdxValue
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
			url:"${pageContext.request.contextPath}/gatherData/replyInsert",
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
	var gatherIdxValue = $("#gatherIdxValue").data("gather-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/gatherData/replyList",
		type:"get",
		data:{
			gatherIdx:gatherIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
			$("#result").empty();//내부영역 청소
			for(var i=0; i<resp.length; i++){
				var template = $("#gatherVO-template").html();
				
				template = template.replace("{{gatherReplyIdx}}",resp[i].gatherReplyIdx);
				template = template.replace("{{gatherReplyIdx}}",resp[i].gatherReplyIdx);
				template = template.replace("{{gatherReplyIdx}}",resp[i].gatherReplyIdx);
				template = template.replace("{{memberNick}}",resp[i].memberNick);
				template = template.replace("{{gatherReplyDetail}}",resp[i].gatherReplyDetail);
				template = template.replace("{{gatherReplyDate}}",resp[i].gatherReplyDate);
				
				var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
				
				console.log(tag.find(".remove-btn"));
				
				//댓글 삭제
				tag.find(".remove-btn").click(function(){
					console.log("누름");
					deleteReply($(this).data("gatherreply-idx"));
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



<!-- 댓글삭제 -->
<script>
function deleteReply(gatherReplyIdxValue){

	$.ajax({
//			url:"${pageContext.request.contextPath}/data/data8?examId="+examIdValue,
		url:"${pageContext.request.contextPath}/gatherData/replyDelete?"+$.param({"gatherReplyIdx":gatherReplyIdxValue}),
		type:"delete",
			data:{
				gatherReplyIdx : gatherReplyIdxValue
			},
		dataType:"text",
		success:function(resp){
			console.log("성공", resp);
			
			loadList();
		},
		error:function(e){}
	});
}
</script>




















