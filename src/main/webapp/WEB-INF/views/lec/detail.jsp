<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


 
<h2>${lecDetailVO.lecName} 강좌 상세 </h2>

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


<!-- 댓글 -->
<div class="collapse" id="reply_card${tmp.no}">
	<div class="card card-body">
		<!-- 댓글 목록 -->
		<div class="reply-list reply-list${tmp.no}">
			<!-- 댓글 목록이 들어감 -->
		</div>
		<!-- 댓글 작성 => 로그인 상태여야 나옴 -->
		<c:if test="${memberIdx != null}">
			<div class="row reply_write">
				<!-- 프로필 이미지 넣을건데 잘 모르겟음 -->
				<div class="col-1">
					<a href="">
						<img id="reply_profileImage" src="몰겟">
					</a>
				</div>
				<div class="col-8" class="input_reply_div">
					<input class="w-100 form-control" id="input_reply${tmp.no}"
						type="text" placeholder="댓글입력">
				</div>
				<div class="col-3">
					<button type="button" id="${tmp.no}"
						class="btn btn-success mb-1 write_reply">댓글&nbsp;달기</button>
				</div>
			</div>
		</c:if>
	</div>
</div>

<a href="insert">글쓰기</a>
<a href="list">목록보기</a>
<a href="#">수정</a>			
<a href="delete?lecIdx=${lecDetailVO.lecIdx}">삭제</a>	
