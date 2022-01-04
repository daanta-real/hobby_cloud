<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- LINKS -->
<!-- Bootstrap Theme -->
<LINK rel="stylesheet"
	href="https://bootswatch.com/5/journal/bootstrap.css">
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

<c:set var="isLogin" value="${memberIdx != null}"/>

<c:choose>
<c:when test="${isLogin}">

<h1>로그인</h1>
</c:when>
</c:choose>

<h2 id="gatherIdxValue" data-gather-idx="${GatherVO.gatherIdx}">${GatherVO.gatherIdx}번 게시글 </h2>

<table border="1" width="80%">
	<tbody>
		<tr>
			<td>
				<h3>${GatherVO.gatherName}</h3>
			</td>
		</tr>
		<tr>
			<td>
				작성자 :${GatherVO.memberNick}
				|
				장소 : ${GatherVO.gatherLocRegion}
			</td>
		</tr>
		<!-- 답답해 보이지 않도록 기본높이를 부여 -->
		<!-- 
			pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
			(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다) 
		-->
		<tr height="250" valign="top">
			<td>
								
				<pre>${GatherVO.gatherDetail}23</pre>
				
			<!-- 참가자 리스트 반복문 -->
		
			<c:forEach var ="GatherHeadsVO" items="${list2}">
 			
 			<c:set var="join" value="${GatherHeadsVO.memberIdx eq memberIdx}"></c:set>
			
			<h1>${memberIdx}</h1>
			<h1>${GatherHeadsVO.memberIdx }</h1>
			<tr>
			<th>닉네임</th>
			<th>프로필</th>
			</tr>
			<tr>
			<td>${GatherHeadsVO.memberNick}</td>
			<td>${GatherHeadsVO.gatherIdx}</td>

			
			</tr>
			<h1>세션:${memberIdx}</h1>
			<h1>아이디 :${GatherHeadsVO.memberIdx}</h1>
			</c:forEach>			
			
		<!-- 게시판 사진 반복문 -->	
			<c:forEach var="GatherFileDto" items="${list}"> 
			<span><${GatherFileDto.gatherFileUserName}</span>
			<br>
			<img src="${pageContext.request.contextPath}/gather/file/${GatherFileDto.gatherFileIdx}" width="30%" class="image image-round image-border">			
			</c:forEach>

			
		</td>
		
		</tr>
		<!-- 소모임 참가 /취소 버튼 -->

			<tr>
			<td>
			<!-- 참가하기 버튼 -->
			<c:choose>
			<c:when test="${!join}">
			<a class="btn btn-primary" href="${pageContext.request.contextPath}/gather/join?gatherIdx=${GatherVO.gatherIdx}">참가하기</a>
			</c:when>
			<c:otherwise>
			<a class="btn btn-secondary" href="${pageContext.request.contextPath}/gather/cancel?gatherIdx=${GatherVO.gatherIdx}">취소하기</a>
			</c:otherwise>
			</c:choose>
			</td>
			</tr>
			
			
 
		<tr>
		<td>	
				<a href="${pageContext.request.contextPath}/gather/insert">글쓰기</a>
				<a href="${pageContext.request.contextPath}/gather/list">목록보기</a>
				<a href="${pageContext.request.contextPath}/gather/update/${GatherVO.gatherIdx}">수정</a>			
				<a href="${pageContext.request.contextPath}/gather/delete?gatherIdx=${GatherVO.gatherIdx}">삭제</a>	
	
			</td>
		</tr>
	</tbody>
</table>

<!-- 게시판 작성 목록 -->
<h1>댓글</h1>

<form id="insert-form">
	내용 : <input type="text" name="gatherReplyDetail">
		<br>
		  <input type="hidden" name="gatherIdx" value="${GatherVO.gatherIdx}">
		  <input type="hidden" name="memberIdx" value="1">
	<button type="submit">등록</button>
</form>


<!-- 게시판 댓글 목록 -->
<template id="gatherVO-template">
<div class="item">
<span class="gatherReplyIdx">{{gatherReplyIdx}}</span>
<span class="memberNick">{{memberNick}}</span>
<span class="gatherReplyDetail">{{gatherReplyDetail}}</span>
<span class="gatherReplyDate">{{gatherReplyDate}}</span>
<button class="remove-btn" data-gatherReplyIdx="{{gatherReplyId}}">삭제</button>
</div>
</template>

<div id="result"></div>











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
				template = template.replace("{{memberNick}}",resp[i].memberNick);
				template = template.replace("{{gatherReplyDetail}}",resp[i].gatherReplyDetail);
				template = template.replace("{{gatherReplyDate}}",resp[i].gatherReplyDate);
				
				var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
				
				
				
				//삭제 버튼 클릭 시
				tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
				console.log("찾음");
					deleteData($(this).data("gatherReplyIdx"));
				
				});
				
				
		
				
				$("#result").append(template);
			}
		},
		error:function(e){
			console.log("실패",e);
		}
	});
}


function deleteData(gatherReplyIdxValue){
	$.ajax({
		url:"${pageContext.request.contextPath}/gatherData/replyDelete"+$.param({"gatherReplyIdx":gatherReplyIdxValue}),
		type:"delete",
		dataType:"text",
		success:function(resp){
			console.log("성공",resp),
			loadList();
		},
		error:function(e){
			console.log("실패", e);
		}
		
	});
	
}

</script>

<script>

$.ajax({
	
})
</script>






