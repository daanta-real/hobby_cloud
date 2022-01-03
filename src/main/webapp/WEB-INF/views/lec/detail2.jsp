<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%-- <script src="${pageContext.request.contextPath}/views/lec/reply.js"></script> --%>
<script>
$(function(){
	//처음 들어오면 목록 출력
	replyList();
	
	function replyList(){
		//#result에 목록을 불러와서 출력
		var lecIdxValue = $("#lecIdxValue").data("lec-idx");
		$.ajax({
			url:"${pageContext.request.contextPath}/lecData/replyList",
			type:"get",
			data:{
				lecIdx:lecIdxValue
			},
			dataType:"json",
			success:function(resp){
				console.log("성공",resp);
				$("#result").empty();//내부영역 청소
				//$("#result").html("");
				//$("#result").text("");
				
				for(var i=0; i < resp.length; i++){
					var template = $("#lecReplyVO-template").html();
					
					template = template.replace("{{lecReplyIdx}}",resp[i].lecReplyIdx);
					template = template.replace("{{memberNick}}",resp[i].memberNick);
					template = template.replace("{{lecReplyDetail}}",resp[i].lecReplyDetail);
					template = template.replace("{{lecReplyRegistered}}",resp[i].lecReplyRegistered);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
						deleteData($(this).data("lecReplyIdx"));
					});
					tag.find(".edit-btn").click(function(){
						var lecReplyDetail = $(this).prevAll(".lecReplyDetail").text();
						
						var form = $("<form>");
						form.append("<input type='hidden' name='lecReplyIdx' value='"+lecReplyIdx+"'>");
						form.append("<input type='text' name='lecReplyDetail' value='"+lecReplyDetail+"'>");
						form.append("<button type='submit'>수정</button>");
						
						form.submit(function(e){
							e.preventDefault();
							
							//ajax...
						});
						
						var div = $(this).parent();
						div.html(form);
					});
					$("#result").append(tag);//추가!
				}
			},
			error:function(e){}
		});
	}
	function deleteData(examIdValue){
		
		$.ajax({
// 			url:"${pageContext.request.contextPath}/data/data8?examId="+examIdValue,
			url:"${pageContext.request.contextPath}/data/data8?"+$.param({"examId":examIdValue}),
			type:"delete",
// 			data:{//delete일 경우 사용 불가
// 				examId : examIdValue
// 			},
			dataType:"text",
			success:function(resp){
				console.log("성공", resp);
				
				loadList();//데이터가 변하면 무조건 갱신
			},
			error:function(e){}
		});
	}
	
	
	
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

<!-- 댓글 작성 => 로그인 상태여야 나옴 -->
<c:if test="${memberIdx != null}">
	<form id="insert-form">
		<!-- 프로필 이미지 넣을건데 잘 모르겟음 -->
		<div>
			<a href="">
				<img src="${pageContext.request.contextPath}/member/profile/${memberIdx}">
			</a>
		</div>
		<div>
			<input type="text" id="input-reply" name="lecReplyDetail" placeholder="댓글입력">
			<input type="hidden" name="lecIdx" value="${lecDetailVO.lecIdx}">
		 	<input type="hidden" name="memberIdx" value="${memberIdx}">
		</div>
		<div>
			<button type="submit" class="btn">댓글 달기</button>
		</div>
	</form>
</c:if>


<a href="insert">글쓰기</a>
<a href="list">목록보기</a>
<a href="#">수정</a>			
<a href="delete?lecIdx=${lecDetailVO.lecIdx}">삭제</a>	
