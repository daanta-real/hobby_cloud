<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<script>
function wrapclear(){
    $('.popup-wrap').css('opacity','0').css('display','none');
}
  $(function(){
	$("#findbtn").click(function(){
			alert("sdfd");
			var name = $("#nameId").val();
			var email = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("name : " + name);
			 console.log("email : " + email);
			 alert(phone);
			    $.ajax({
			    	type : "post",
			        url : "idfindMail.do",
			        data : {"name" : name, "email" : email},
			        success : function(resp){
			        	console.log()
			        	alert("ajax 성공!! ");
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

<script>
	function openPage(pageName,elmnt,color) {
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].style.backgroundColor = "";
	    tablinks[i].style.color = "black";
	  }
	  document.getElementById(pageName).style.display = "block";
	  elmnt.style.backgroundColor = "#015B28";
	  elmnt.style.color = "white";
	}
	
	$(document ).ready(function(){
		document.getElementById("defaultOpen").click();
	})
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
                	<button class="tablink" onclick="openPage('cate1', this, '#f7f7f7')" id="defaultOpen">Email</button>
					<button class="tablink" onclick="openPage('cate2', this, '#f7f7f7')" id="phoneOpen">Phone</button>
					</div>
					<div id="cate1" class="tabcontent">
					<input type="text" id="nameId" class="input form-control" name="name" placeholder="이름">
					<br>
					<div class="inputag">
					   <input type="text"  id="idMail" name="email_id" class="input form-control"  placeholder="EMAIL" >
						<div style="margin: 10px 10px 10px 10px;">@</div> 
						<input type="text" id="inputMail" name="email_domain" class="input form-control" placeholder="EMAIL" >
						
					 </div>

					 
					</div>
					
					<div id="cate2" class="tabcontent">
					    <input type="text" id="nameId" class="input form-control" name="name" placeholder="이름">
					    <br>
					    <div class="inputag">
					            <input type="text" id="phone1" name="phone1" 
					                class="input form-control phone" maxlength="3" 
					                placeholder="000"> 
					                <div style="margin: 7px 10px 10px 10px;">-</div>
					            <input type="text" id="phone2" name="phone2" 
					                class="input form-control phone" maxlength="4" 
					                placeholder="0000"> 
					                <div style="margin: 7px 10px 10px 10px;">-</div>
					            <input type="text" id="phone3" name="phone3" 
					                class="input form-control phone" maxlength="4"
					                placeholder="0000">	
					            <input type="hidden" id="phoneNum" name="phone">
					    </div>
					    
					</div>
                  <br>
                  <br>
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
                                    회원님의 아이디는 ${vo.memberId } 입니다.
                                </p>
                                <div class="buttons">
                                    <button class="button reser payment">로그인</button>
                                    <button class="button reser clear">비밀번호 찾기</button>
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