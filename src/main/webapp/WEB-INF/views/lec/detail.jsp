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

<!-- 좋아요 부분 -->
<script>
$(function(){
	$('#like-btn').click(function(){
		likeUpdate();
	});
	
	function likeUpdate(){
		memberIdx = $('#memberIdx').val(),
		lecIdx = $('#lecIdx').val(),
		count = $('#like-check').val(),
		data = {"memberIdx" : memberIdx,
				"lecIdx" : lecIdx,
				"count" : count};
		
	$.ajax({
		url : "${pageContext.request.contextPath}/lecData/likeUpdate",
		type : 'POST',
		contentType: 'application/json',
		data : JSON.stringify(data),
		success : function(result){
			console.log("수정" + result.result);
			if(count == 1){
				console.log("좋아요 취소");
				 $('#like-check').val(0);
				 $('#like-btn').attr('class','btn btn-light');
			}else if(count == 0){
				console.log("좋아요!");
				$('#like-check').val(1);
				$('#like-btn').attr('class','btn btn-danger');
			}
		}, error : function(result){
			console.log("에러" + result.result)
		}
		});
	};
});
</script>
<c:if test="${memberIdx != null}">
	<div id="like">
	<c:choose>
		<c:when test="${isLike == 0}">
			<button type="button" class="btn btn-light" id="like-btn">좋아요</button>
			<input type="hidden" id="like-check" value="${isLike}">
			<input type="hidden" id="memberIdx" value="${memberIdx}">
			<input type="hidden" id="lecIdx" value="${lecDetailVO.lecIdx}">
		</c:when>					
		<c:when test="${isLike == 1}">
			<button type="button" class="btn btn-danger" id="like-btn">좋아요</button>
			<input type="hidden" id="like-check" value="${isLike}">
		</c:when>
	</c:choose>
</div>
</c:if>

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

<!-- <!-- 댓글작성 영역 --> -->
<!-- <div class="board_cmt"> -->
<!--     <div class="tit" style="margin-left: 6px;"><em id="totalCmt" class="bico_comment"></em>Comments</div> -->
<!--      <div class="board_cmt_write"> -->
<!--          <div class="bx">  -->
<!--              <textarea id="cmtContent" placeholder="소중한 댓글을 작성해주세요^^" maxlength="150"></textarea> -->
<!--          </div> -->
<!--         <button id="btn_insert_cmt">등록</button> -->
<!--      </div> -->
<!-- </div> -->
<!-- <!-- 댓글 목록 영역 --> -->
<!-- <div class="board_cmt_list" id="board_cmt_list" style="margin-left:6px;"></div> -->
<!-- <div style="text-align: center; margin: 20px 0px;" id="div_cmt_more"> -->
<!--  <!-- 더보기 글자 hover 띄우기 --> -->
<!--     <span class="cmt_more_guide" id="cmt_more_guide" style="display: none; position: absolute;"></span> -->
<!--     <a href='javascript:void(0);' id='btn_cmt_more' style='position: relative;'> -->
<!--         <img src="/home/img/ico_cmt_more_before.png" id="imgMore" style="cursor:pointer; width: 20px;"> -->
<!--     </a> -->
<!-- </div> -->
<!-- <!-- 더보기 눌렀을때 추가 되는 댓글 영역 --> -->
<!-- <div class="board_cmt_list" id="cmtMore" style="display:none;"></div> -->
<!-- <div style="text-align: center; display:none; margin: 20px 0px;" id="div_cmt_back"> -->
<!--     <span class="cmt_back_guide" id="cmt_back_guide" style="display: none; position: absolute;"></span> -->
<!--     <a href='javascript:void(0);' id='btn_cmt_back' style='position: relative;'> -->
<!--         <img src="/home/img/ico_cmt_back_before.png" id="imgBack" style="cursor:pointer; width: 20px;"> -->
<!--     </a> -->
<!-- </div> -->


<a href="insert">글쓰기</a>
<a href="list">목록보기</a>
<a href="#">수정</a>			
<a href="delete?lecIdx=${lecDetailVO.lecIdx}">삭제</a>	
