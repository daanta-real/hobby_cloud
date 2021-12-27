<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<form method="post" enctype="multipart/form-data">

<div class="container-400 container-center">
	<div class="row center">
		<h1>회원가입</h1>
	</div>
	<div class="row">
		<label>아이디</label>
		<input type="text" name="memberId" required class="form-input">
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class="form-input">
	</div>
	<div class="row">
		<label>닉네임</label>
		<input type="text" name="memberNick" required class="form-input">
	</div>
	<div class="row">
		<label>이메일</label>
		<input type="email" name="memberEmail" class="form-input">
	</div>
	<div class="row">
		<label>전화번호</label>
		<input type="tel" name="memberPhone" class="form-input">
	</div>
	<div class="row">
		<label>주소</label>
		<input type="text" name="memberRegion" class="form-input">
	</div>
	<div class="row">
		<label>프로필 이미지</label>
		<input type="file" name="attach" accept="image/*" class="form-input">
	</div>
	<div class="row">
		<label>관심분야</label>
		<input type="checkbox" name="lecCategoryName"  value="sports">스포츠
		<input type="checkbox" name="lecCategoryName"  value="music">음악
		<input type="checkbox" name="lecCategoryName"  value="painting">그림
	</div>
	<div class="row">
		<input type="submit" value="가입" class="form-btn">
	</div>
</div>
	
</form>




