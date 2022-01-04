<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%-- <script src="${pageContext.request.contextPath}/views/lec/reply.js"></script> --%>
 
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



<a href="insert">글쓰기</a>
<a href="list">목록보기</a>
<a href="#">수정</a>			
<a href="delete?lecIdx=${lecDetailVO.lecIdx}">삭제</a>	
