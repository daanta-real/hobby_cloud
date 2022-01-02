<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<script>
function wrapclear(){
    $('.popup-wrap').css('opacity','0').css('display','none');
}
  $(function(){
	$("#findbtn").click(function(){
			alert("작동시작");
			var memberId = $("#memberId").val();
			var memberNick = $("#memberNick").val();
			var memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("memberNick : " + memberNick);
			 console.log("memberEmail : " + memberEmail);
			 alert(email);
			    $.ajax({
			    	type : "post",
			        url : "pwFindMail",
			        data : {"memberId" : memberId, "memberNick" : memberNick, "memberEmail" : memberEmail},
			        success : function(resp){
			        	console.log()
			        	alert("ajax 성공!! ");
			        	alert(resp);
			        	console.log("resp : " + resp);
			        	if(resp == "success") {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("임시비밀번호가 전송되었습니다.");
					        $(".payment").hide();
					        $('.popup-close').click(wrapclear);
	
			        	} else {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("비밀번호 재설정이 실패했습니다.");
					        $(".clear").hide();
					        $('.popup-close').click(wrapclear);
			        	}
			        	}
			        }, 
			    });
	 });
});
  
 
 
</script>

   

<body>

	<form method="post">

		<div class="wrap">

			<div id="cont1">
				<div id="panel" class="panel panel-default">
					<div class="panel-heading">비밀번호 찾기</div>
					<div class="panel-body">
						<button>Email</button>


						<div id="mail" class="tabcontent">

                	<input type="text" id=memberId  name="memberId" placeholder="ID"> 
					<input type="text" id="memberNick"  name="memberNick" placeholder="닉네임">
					<br>
					<div class="inputag">
					   <input type="text"  id="idMail" name="email_id" class="input form-control nameId"  placeholder="EMAIL" >
						@
						<input type="text" id="inputMail" name="email_domain" class="input form-control nameId" placeholder="EMAIL" >
					</div>
                  <br>
                  <br>
                </div>
            </div>
                <div class="button-box">
				<input type="button" class="btn btn-default btn01" value="뒤로가기" onclick="history.back()">   
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<button type="button" id="findbtn" class="btn btn-default btn01">재설정하기</button>
			</div>     
			<br><br>
				</div>
				<br>
				<br>

			</div>
		</div>

	</form>






</body>

</html>