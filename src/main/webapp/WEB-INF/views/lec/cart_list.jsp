<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 나의 찜 목록</TITLE>
<script>
$(function(){
    $("#btnList").click(function(){
        location.href="${pageContext.request.contextPath}/lec/list";
    });

     // 아래쪽에서 btnlist를 호출해서 실행되는 function() 함수 구문.
     // list로 가는 링크를 만든다.

    $("#btnDelete").click(function(){
        if(confirm("찜을 비우시겠습니까?")){
            location.href="${pageContext.request.contextPath}/lec/cart/deleteAll";
        }
    });
});
</script>
</HEAD>
<BODY>
<jsp:include page="/resources/template/body.jsp" flush="false" />

<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">

<!-- 사이드메뉴 영역 시작 -->
<!-- 사이드메뉴 영역 끝 -->

<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			나의 찜 목록
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
	<!-- 소단원 제목 -->
<!-- 		<div class='row border-bottom border-1 my-4 mx-2 p-1 fs-3 fw-bold'>강좌 정보</div> -->
		<!-- 소단원 내용 -->
		<div class="row p-sm-2 mx-1 mb-5">
			<c:choose>
		    <c:when test="${map.count == 0}">
		    <!-- when은 ~~일때 라는 뜻 그러니까 map의 count가 0일때... -->
		    <!-- xml파일에서 hashmap에 list를 넣어놓았기 때문에 현재 map에 자료가 들어있다.  -->
		    <!-- map에 자료가 아무것도 없다면 -->
		        찜 목록이 비었습니다.
		    </c:when>
		    
		    <c:otherwise>
		    <!-- map.count가 0이 아닐때, 즉 자료가 있을때 -->
		    <!-- form을 실행한다.  -->
		    <!-- form의 id를 form1로 하고, method 방식을 post로 한다. 그리고 update페이지로 이동시킨다. -->
		        <form id="form1" name="form1" method="post"
		        action="${pageContext.request.contextPath}/lec/cart/update">
		            <table border="1" width="400px">
		                <tr>
		                    <th>강좌명</th>
		                    <th>단가</th>
		                    <th>&nbsp;</th>
		                </tr>
		                <!-- map에 있는 list출력하기 위해 forEach문을 사용해 row라는 변수에 넣는다. -->
		            <c:forEach var="row" items="${map.list}">
		                <tr align="center">
		                    <td>${row.lecName}</td>
		                    
		<%--                     <td><fmt:formatNumber value="${row.lecPrice}" --%>
		<!--                             pattern="#,###,###" /></td> -->
							<td>
							${row.lecPrice} 포인트
							<input type="hidden" name="cartIdx" value="${row.cartIdx}">
							</td>
		                            <!-- fmt:formatNumber 태그는 숫자를 양식에 맞춰서 문자열로 변환해주는 태그이다 -->
		                            <!-- 여기서는 금액을 표현할 때 사용 -->
		                            <!-- ex) 5,000 / 10,000 등등등-->
		
		                    <td><a href=
		"${pageContext.request.contextPath}/lec/cart/delete/${row.cartIdx}">[삭제]</a>
		<!-- 삭제 버튼을 누르면 delete로 찜 개별 idㅌ (삭제하길 원하는 찜 idx)를 보내서 삭제한다. -->
		                    </td>
		                </tr>
		            </c:forEach>
		                <tr>
		                    <td colspan="5" align="right">
		                        찜 금액 합계 :
		<%--                         <fmt:formatNumber value="${map.totalPrice}" --%>
		<!--                             pattern="#,###,###" /> -->
								${map.totalPrice}
		                    </td>
		                </tr>
		            </table>
		<!--             <button id="btnUpdate">수정</button> -->
		            <button type="button" id="btnDelete">찜 비우기</button>
		            //btnUpdate와 btnDelete id는 위쪽에 있는 자바스크립트가 처리.
		        </form>
		    </c:otherwise>
		</c:choose>
		<nav class="row p-0 pt-4 d-flex justify-content-between">
			<button type="button" id="btnList" class="col-auto btn btn-sm btn-outline-primary" onclick="location.href='${root}/lec/list';">강좌목록</a></button>
			<button type="button" id="btnPayment" class="col-4 btn btn-outline-primary" onclick="location.href='${root}/lec/check;">결제하기</a></button>
		</nav>
		</div>
	</SECTION>
	<!-- 페이지 내용 끝. -->




</ARTICLE>
<!-- 페이지 영역 끝 -->


</DIV></SECTION>
<!-- 본문 대구역 끝 -->


<!-- ************************************************ 풋터 영역 ************************************************ -->
<jsp:include page="/resources/template/footer.jsp" flush="false" />
</BODY>
</HTML>