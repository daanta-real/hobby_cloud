<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

.popup-wrap .outer .inner .popup-content .buttons button.payment:hover{
    background: #015B28; border: 2px solid #015B28; color: white;
    }
.button.reser{border-width: 2px; font-weight: 700; margin-right: 20px; margin-top: 10px; vertical-align: middle;}
.popup-wrap .outer .inner .popup-content .buttons button.clear{width:143px;margin-left: 28px; background: white; border: 1px solid black; color: black;}
.popup-wrap .outer .inner .popup-content .buttons button.clear:hover{color: #015B28; font-weight: 800;}
.popup-wrap .outer .inner .popup-content button.popup-close{
    background-color: #015B28;
    opacity: 1;
    width: 30px;
    height: 30px;
    right: 0px;
    top: 0px;
    border: 2px solid #015B28;
    transition: .3s background-color;
    display: block;
    position: absolute;
    z-index: 1;
}
.popup-wrap .outer .inner .popup-content button.popup-close:hover{
    background-color: transparent;
}
.popup-wrap .outer .inner .popup-content button.popup-close::before,
.popup-wrap .outer .inner .popup-content button.popup-close::after{
    background-color: #fff;
    margin-top: -1px;
    height: 2px;
    width: 33.3333%;
    left: 50%;
    margin-left: -16.66665%;
    content: '';
    display: block;
    position: absolute;
    top: 50%;
    -webkit-transform: rotate(45deg);
}
.popup-wrap .outer .inner .popup-content button.popup-close:hover::before,
.popup-wrap .outer .inner .popup-content button.popup-close:hover::after{
    background-color: #000;
}
.popup-wrap .outer .inner .popup-content button.popup-close::after{
    transform: rotate(-45deg);
}
.subGroup{
	display: flex;
	justify-content: center;
	margin-top: 25px;
}
/* Style tab links */
.tablink {
	float: left;
    outline: none;
    cursor: pointer;
    padding: 7px 16px;
    font-size: 15px;
    width: 50%;
    vertical-align: middle;
}
.tablink:hover {
  background-color: #015B28;
  color: white;
}
#mal {
  background-color: #015B28;
  color: white;
}

</style>
<script>


function wrapclear(){
    $('.popup-wrap').css('opacity','0').css('display','none');
}

  $(function(){
	$("#findbtn").click(function(){
			alert("작동시작");
			var memberNick = $("#memberNick").val();
			var memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("memberNick : " + memberNick);
			 console.log("memberEmail : " + memberEmail);
			    $.ajax({
			    	type : "post",
			        url : "idfindMail",
			        data : {"memberNick" : memberNick, "memberEmail" : memberEmail},
			        success : function(resp){
			        	console.log()
			        	alert("ajax 성공!!");
			        	alert(resp);
			        	console.log("resp : " + resp);
			        	if(resp == "fail") {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("일치하는 회원정보가 없습니다.");
					        $('.popup-close').click(wrapclear);
	
			        	} else {
			        		$('.popup-wrap').css('opacity','1').css('display','block');
			        		$(".popup-detail").text("");
					        $(".popup-detail").html("회원님의 아이디는 " + resp + " 입니다");
					        $('.popup-close').click(wrapclear);
			        	}
			        }, 
			    });
	 });
});
  
 
 

</script>   

<body>

	    <div class="wrap" >
            <div id="cont1">
                <div id = "panel" class="panel panel-default">
                <div class="panel-heading">
                    아이디 찾기
                </div>
                <div class="panel-body">
                	<br><br>
                	<div class="tabGroup">
                	<button>Email</button>
					</div>
					<div id="cate1" class="tabcontent">
					<input type="text" id="memberNick" class="input form-control" name="memberNick" placeholder="닉네임">
					<br>
					<div class="inputag">
					   <input type="text"  id="idMail" name="email_id" class="input form-control"  placeholder="EMAIL" >
						@
						<input type="text" id="inputMail" name="email_domain" class="input form-control" placeholder="EMAIL" >						
					 </div>					 
					</div>
                </div>
            </div>
            
             <div class="button-box">
	            <button type="button" id="findbtn" class="btn btn-default btn01">찾기</button>
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="btn btn-default btn01" value="뒤로가기" onclick="popUp()">    
			</div>     
			<br><br>


        </div>

    </div>
	
	     <div class="popup-wrap">
             <div class="screen"></div>
                <div class="outer">
                    <div class="inner">
                        <div class="container3">
                            <div class="popup-content">
                                <p>아이디찾기</p>
                                <p class="popup-detail">
                                    회원님의 아이디는 ${memberDto.memberId} 입니다.
                                </p>
                                <div class="buttons">
                                    <button class="button reser payment" onclick="location.href='login'">로그인</button>
                                    <button class="button reser clear" onclick="location.href='pwFindMail">비밀번호 찾기</button>
                                </div>
                                
                                <button type="button" class="popup-close">

                                </button>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>

</body>



</html>