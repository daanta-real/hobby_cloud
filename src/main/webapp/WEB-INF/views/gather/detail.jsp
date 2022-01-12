<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %> 
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


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

<c:set var = "start" value = " ${GatherVO.gatherStart}"/>
<c:set var = "startTime" value = "${fn:substring(start, 0, 17)}" />  
<c:set var = "end" value = " ${GatherVO.gatherEnd}"/>
<c:set var = "endTime" value = "${fn:substring(end, 0, 17)}" />


<jsp:include page="/resources/template/body.jsp" flush="false" /> 
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">

<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->
		<HEADER class='w-100 mb-1 p-2 px-md-3'>  
		
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			소모임
			</span>
		</div> 
	</HEADER> 
		<!-- 소단원 내용 --> 
		<h2 class="d-none" id="gatherIdxValue" data-gather-idx="${GatherVO.gatherIdx}">${GatherVO.gatherIdx}번게시글</h2> 
		<input type="hidden" name="gatherLocLongitude" value="${GatherVO.gatherLocLongitude}">
        <input type="hidden" name="gatherLocLatitude"  value="${GatherVO.gatherLocLatitude}">
		<div id="map" style="width:50%;height:350px;"></div>
		<h1>참여자 수 :${fn:length(list2)} / ${GatherVO.gatherHeadCount}</h1> 
		<!-- 소단원 제목 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>${GatherVO.gatherName}</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<div class="row row justify-content-end">
				등록일 :
				| 
				작성자 : ${GatherVO.memberNick}
				|
				소모임시간 : ${startTime} ~ ${endTime} 
				|
				장소 : ${GatherVO.gatherLocRegion}
				</div>
				<div class="row">
				${GatherVO.gatherDetail}
				</div>
					<c:forEach var="GatherFileDto" items="${list}">
					<span><${GatherFileDto.gatherFileUserName}</span>
					<br>
				<img src="${pageContext.request.contextPath}/gather/file/${GatherFileDto.gatherFileIdx}"
						width="15%" class="image image-round image-border"> 
				</c:forEach>

	
	 
	<div id="map" style="width: 100%; height: 50px; border-radius: 50px;"></div> 
	<!-- 소모임 테이블 영역  -->
	<div class="row p-sm-2 mx-1 mb-5">
			<div class="scrollXEnabler">
				<div class="card p-0 minWidthMaxContent">
					<table class="table table-striped table-hover table-bordered table-sm table-responsive m-0">
						<thead>
							<tr class="table-danger">
								<th scope="col" class="text-center align-middle text-nowrap">프로필</th>
								<th scope="col" class="text-center align-middle text-nowrap">닉네임</th>
							</tr>
						</thead>
						<tbody>
				  
						<c:forEach var="GatherHeadsVO" items="${list2}" varStatus="status">
						
						 <tr class="cursor-pointer">     
							<td class="text-center align-middle text-nowrap">${GatherHeadsVO.memberProfileIdx}</td>  
							<td class="text-center align-middle text-nowrap">${GatherHeadsVO.memberNick}</td> 
						<c:set var="isFull" value="false" />
						<!-- 참가자가 가득찻는지 확인-->
						<c:if test="${status.count == GatherVO.gatherHeadCount}">  
						<c:set var="isFull" value="true" />
						</c:if>
						  
						 
						<!-- 참가여부를 확인 -->
						<c:set	var="isJoin" value="false" /> 
						<c:if test="${GatherHeadsVO.memberIdx eq memberIdx}">
						${GatherHeadsVO.memberIdx} /${memberIdx}
						<c:set var="isJoin" value="true" />
						</c:if>
						</c:forEach> 
						 </tr>	
						</tbody>
					</table>
				</div>
			</div> 	


				<!-- 참가하기 버튼 -->
				<c:set var="isLogin" value="${memberIdx != null}"/>
				 <c:choose>
					<c:when test="${isJoin}">
						<a class="btn btn-warning"
							href="${pageContext.request.contextPath}/gather/cancel?gatherIdx=${GatherVO.gatherIdx}">취소하기</a>
					</c:when>
					<c:when test="${isFull}">
						<a class="btn btn-secondary fullBtn">완료</a>
					</c:when>
					<c:when test="${isLogin}"> 
						<a class="btn btn-primary"
							href="${pageContext.request.contextPath}/gather/join?gatherIdx=${GatherVO.gatherIdx}">참가하기</a>
					</c:when>
				</c:choose>
			<script>
			$(function(){
				$(".fullBtn").click(function(){
					alert("모집이 마감되었습니다.")
				});
			})
			</script>
		
		
			<!-- 각종 버튼들 -->
			<nav class="row p-0 pt-4 d-flex justify-content-end">
				<a href="${pageContext.request.contextPath}/gather/list"
				 class="col-auto btn btn-sm btn-outline-primary mx-1">목록 보기</a>
				<a href="${pageContext.request.contextPath}/gather/insert" class="col-auto btn btn-sm btn-outline-primary mx-1">글 작성</a>
				<a href="${pageContext.request.contextPath}/gather/update/${GatherVO.gatherIdx}"
				 class="col-auto btn btn-sm btn-secondary mx-1">수정</a>
				<a href="${pageContext.request.contextPath}/gather/delete?gatherIdx=${GatherVO.gatherIdx}" 
				class="col-auto btn btn-sm btn-danger mx-1">삭제</a>   
				<button class="btn btn-secondary more-btn">더보기!!</button>    
			</nav>
		
		<!-- 댓글 내역 -->
		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>댓글</div>
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
		<form id="insert-form">
		<div class="card mb-2 border border-1 border-secondary p-0">
					<div class="card-header d-flex align-items-center p-1 px-2">
						<span>댓글을 입력해주세요</span>
					</div> 
				<div class="card-body position-relative p-1 px-2">
				  <input type="text" class="card-text p-1 px-3 gatherReplyDetail" name="gatherReplyDetail">
				 <input	type="hidden" name="gatherIdx" value="${GatherVO.gatherIdx}">
				<input type="hidden" name="memberIdx" value="${memberIdx}"> 
				  <button type="submit" class="btn btn-sm btn-secondary p-1 me-1">등록</button> 
				</div>	  
				<div class="floatRightTop position-absolute top-0 end-0 p-1">  
			</div>	
		</div>
</form>
<div id="result"></div> 


<!-- 게시판 댓글 목록 --> 
<template id="gatherVO-template">
<div class="card mb-2 border border-1 border-secondary p-0 item">
	<div class="card-header d-flex align-items-center p-1 px-2">
	<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
	<span class="memberNick">{{memberNick}}</span>
	<span class="memberReplyRegistered ms-auto gatherReplyDate">{{gatherReplyDate}}</span>
	</div>  
	<div class="card-body position-relative p-1 px-2">
	<div class="card-text p-1 px-3 gatherReplyDetail">{{gatherReplyDetail}}</div>

	<div class="floatRightTop position-absolute top-0 end-0 p-1">
	<button type="button" class="btn btn-sm btn-secondary p-1 me-1 edit-btn" data-gatherreply-idx="{{gatherReplyIdx}}">수정</button>
	 <button type="button" class="btn btn-sm btn-secondary p-1 me-1 remove-btn" data-gatherreply-idx="{{gatherReplyIdx}}">삭제</button>
	 </div>  
	</div>
	  
</div>

</template>   
	<button class="more-btn btn btn-secondary">더보기!!</button>  
</div>


  
	
<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>평점</div>
<!-- 소단원 내용 --> 
	<div class="row p-sm-2 mx-1 mb-5">
<form id="insertReview-form">
<div class="card mb-2 border border-1 border-secondary p-0">
	<div class="card-header d-flex align-items-center p-1 px-2">
		<span>평점을 입력해주세요</span>
		</div>
		<div class="card-body position-relative p-1 px-2"> 
		
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
	 <input type="text" name="gatherReviewDetail">
	<input	type="hidden" name="gatherIdx" value="${GatherVO.gatherIdx}">
	  <button type="submit" class="btn btn-sm btn-secondary p-1 me-1">등록</button> 
	  </div>
	 </div>
</form>
<div id="resultReivew"></div>  
<!-- 평점목록 --> 
<template id="gatherReviewVO-template">
<div class="card mb-2 border border-1 border-secondary p-0 item">
	<div class="card-header d-flex align-items-center p-1 px-2">
	<img class="memberImage rounded-circle border border-light border-2 me-1 bg-info" style="width:2.3rem; height:2.3rem;"/>
	<span class="memberNick">{{memberNick}}</span> 
	<span class="gatherReviewScore">   점수:{{gatherReviewScore}}</span> 
	<span class="memberReplyRegistered ms-auto gatherReplyDate">{{gatherReplyDate}}</span>
	</div>   
	<div class="card-body position-relative p-1 px-2">
	<div class="card-text p-1 px-3 gatherReviewDetail">{{gatherReviewDetail}}</div>

	<div class="floatRightTop position-absolute top-0 end-0 p-1">
	<button type="button" class="btn btn-sm btn-secondary p-1 me-1 edit-btn" data-gatherreview-idx="{{gatherReviewIdx}}">수정</button>
	 <button type="button" class="btn btn-sm btn-secondary p-1 me-1 remove-btn" data-gatherreview-idx="{{gatherReviewIdx}}">삭제</button>
	 </div>  
	</div>
</div>

</template>
		
</div>



 


<h1>차트 예제</h1>
 
<canvas id="myChart" width="1%" height="1%"></canvas>
		

</div>
	</SECTION>
	<!-- 페이지 내용 끝. -->
	
</ARTICLE> 
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->

<jsp:include page="/resources/template/footer.jsp" flush="false" />
 
<script>
$(function(){
	var gatherIdx = $("#gatherIdxValue").data("gather-idx");
$.ajax({
	url:"${pageContext.request.contextPath}/gatherData/genderCount", 
	type:"get",
	data:{
		gatherIdx:gatherIdx
	},
	dataType:"json",
	success:function(resp){
		console.log("성공", resp);
		
		draw("#myChart", resp);
	},
	error:function(e){}
});
});
	
	function draw(selector, data){//select = 선택자 , data = JSON(List<ChartVO>)
		//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
		var ctx = $(selector)[0].getContext("2d");
	
		//List<ChartVO> 처럼 {text:?, count:?} 형태의 값이 List로 들어있는 data를
		//text만 뽑아서 배열 한 개를 만들고, count만 뽑아서 배열 한 개를 만든다
		
		var memberGenderArray = [];//gender만 모아둘 배열
		var countArray = [];//count만 모아둘 배열

		
		for(var i=0; i < data.length; i++){
			memberGenderArray.push(data[i].memberGender);
			countArray.push(data[i].count);
		}
		console.log(memberGenderArray);
		console.log(countArray);
	
		//var myChart = new Chart(펜객체, 차트옵션);
		var myChart = new Chart(ctx, {
		    type: 'bar', //차트의 유형
		    data: { //차트 데이터
		    	
		    	//하단 제목
		        labels: memberGenderArray,
		        datasets: [{
		            label: '인원 수',//차트 범례
		            data: countArray,//실 데이터(하단 제목과 개수가 일치하도록 구성)
		            backgroundColor: [//배경색상(하단 제목과 개수가 일치하도록 구성)
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		                
		            ],
		            borderColor: [//테두리색상(하단 제목과 개수가 일치하도록 구성)
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)' 
		                
		            ],
		            borderWidth: 5//테두리 두께
		        }]
		    },
		    options: {
		        scales: {
		            y: {
		                beginAtZero: true
		            }
		        }
		    }
		});
	}
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
					form.append("<div class='star-rating space-x-4 mx-auto'> <input type='radio' id='5-stars' name='gatherReviewScore'value='5' v-model='ratings'/> <label for='5-stars' class='star pr-4'>★</label> <input type='radio' id='4-stars' name='gatherReviewScore' value='4' v-model='ratings'/>   <label for='4-stars' class='star'>★</label>  <input type='radio' id='3-stars' name='gatherReviewScore' value='3' v-model='ratings'/><label for='3-stars' class='star'>★</label><input type='radio' id='2-stars' name='gatherReviewScore' value='2' v-model='ratings'/>    <label for='2-stars' class='star'>★</label> <input type='radio' id='1-star' name='gatherReviewScore' value='1' v-model='ratings' /> <label for='1-star' class='star'>★</label>");
					form.append("</div>");
					form.append("<button type='submit'>수정</button>");
					
					form.submit(function(e){
					e.preventDefault();
						
					var dataValue = $(this).serialize();
					console.log(dataValue);
					
					$.ajax({
						url:"${pageContext.request.contextPath}/gatherData/reviewEdit",
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
var page = 1;
var size = 10;
var gatherIdx= "${gatherIdx}";

$(function(){ 
	$(".more-btn").click(function(){
		loadList(page,size,gatherIdx);
		page++;
	});
	$(".more-btn").click(); 
	console.log(4);
});


$(function(){
	//처음 들어오면 목록 출력
	loadList(page,size,gatherIdx);
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
				loadList(page,size,gatherIdx);
			},
			error:function(e){
				console.log("실패", e);
				console.log(dataValue);
			}
		});
	});
});




//댓글 목록 리스트
function loadList(pageValue, sizeValue, gatherIdxValue){
	var gatherIdxValue = $("#gatherIdxValue").data("gather-idx");
	$.ajax({
		url:"${pageContext.request.contextPath}/gatherData/replyList",
		type:"get",
		data:{
			page:pageValue,
			size:sizeValue,
			gatherIdx:gatherIdxValue
		},
		dateType:"json",
		success:function(resp){
			console.log("성공",resp);
			if(resp.length < sizeValue){
				$(".more-btn").remove();
			}
			
			
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
					
					 $(this).parent().prevAll
					var gatherReplyIdx = $(this).data("gatherreply-idx"); 
					var memberNick = $(this).parent().parent().prevAll(".memberNick").text();
					var gatherReplyDetail = $(this).parent().prevAll(".gatherReplyDetail").text();
					var gatherReplyDate = $(this).parent().prevAll(".gatherReplyDate").text();
					
					var form =$("<form>");
					   
					console.log(gatherReplyIdx);
					console.log(gatherReplyDetail);
					
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
							loadList(page,size,gatherIdx);				
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
			
			loadList(page,size,gatherIdx);
		},
		error:function(e){}
	});
}
</script>


