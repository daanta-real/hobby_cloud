<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script>
    	$(function(){
    		$("form").submit(function(e){
    			e.preventDefault();
    			
    			$(this).find("input[type=password]").each(function(){
    				var origin = $(this).val();
    				var hash = CryptoJS.SHA1(origin);
    				var encrypt = CryptoJS.enc.Hex.stringify(hash);
    				$(this).val(encrypt);
    			});
    			
    			this.submit();
    		});
    	});
    </script>

<form method="post">

<div class="container-400 container-center">
	<div class="row center">
		<h1>회원 로그인</h1>
	</div>
	<div class="row"> 
		<label>아이디</label>
		<input type="text" name="memberId" required class="form-input" autocomplete="off" value="${cookie.saveId.value}">
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class="form-input">
	</div>
	
		<div class="row">
		<label>
			<c:choose>
				<c:when test="${cookie.saveId == null}">
					<input type="checkbox" name="saveId">
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="saveId" checked>
				</c:otherwise>
			</c:choose>
			아이디 저장
		</label>
	</div>
	
	<div class="row right">
		<input type="submit" value="로그인" class="form-btn form-inline">
	</div>

	<c:if test="${param.error != null}">
	<div class="row center"> 
		<h4 class="error">로그인 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
</div>

</form>
