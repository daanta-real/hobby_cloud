<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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
</head>
<body>


<h2>찜</h2>
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
<button type="button" id="btnList">강좌목록</button>
<button type="button" id="btnPayment">결제하기</button>
</body>
</html>