<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 원화 표시 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<HTML LANG="ko">

<!-- ************************************************ 헤드 영역 ************************************************ -->
<HEAD>
<jsp:include page="/resources/template/header.jsp" flush="false" />
<TITLE>HobbyCloud - 마이 페이지</TITLE>
<script type='text/javascript'>
//문서가 로드되자마자 실행될 내용을 여기다 담으면 된다.
window.addEventListener("load", function() {
$('.modal').css('opacity','0').css('display','none');
	
	// 이메일 유효성 검사
	
    $("#emailBox").change(function() {
        if ($("#emailBox").val() == "directly") {
            $("#inputMail").attr("readonly", false);
            $("#inputMail").val("");
            $("#inputMail").focus();
             $("#inputMail").keyup(function(){
                 if(!email_domail.test($("#inputMail").val())){
		                    $("#mailComm").text("");
		                    $("#mailComm").css("color", "red");
		                    $("#mailComm").html("이메일 형식이 맞지 않습니다.");
		                    
		                    mailBoxCheck = false;
		                    
                    } else {
                        $("#mailComm").html("");
                        
                        mailBoxCheck = true;
                    }
                 });
        }  else {
            $('#inputMail').val($('#emailBox').val());
            $("#inputMail").attr("readonly", true);
        }
    });
	
    // 모달 변수 정의
    window.modal = new bootstrap.Modal(document.getElementById("modal"), {
        keyboard: false
    });
});
// 라이브러리: 이벤트 버블링 막기
function stopEvent() {
    if(typeof window.event == 'undefined') return;
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}
    
$(function(){
	$("#findbtn").click(function(){
			alert("작동시작");
			
		    // 이벤트 버블링 막기
		    stopEvent();
		    
		    //비밀번호 재설정 (아이디, 닉네임, 이메일 전달)
			var memberId = $("#memberId").val();
			var memberNick = $("#memberNick").val();
			var memberEmail = $("#idMail").val() + "@" + $("#inputMail").val();
			 console.log("memberNick : " + memberNick);
			 console.log("memberEmail : " + memberEmail);
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
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("임시비밀번호가 전송되었습니다.");
	
			        	} else {
			        		$('.modal').css('opacity','1').css('display','block');
			        		$(".modal-detail").text("");
					        $(".modal-detail").html("비밀번호 재설정이 실패했습니다.");
			        		}
			        	}
			    });
			    // 모달 토글
			    modal.toggle();
		});
	 });
</script>
</HEAD>
<BODY>


<jsp:include page="/resources/template/body.jsp" flush="false" />



<!-- ************************************************ 본문 대구역 시작 ************************************************ -->
<!-- 본문 대구역 시작 -->
<SECTION class="container-fluid"><DIV class="row d-flex flex-col justify-content-center pt-3 pt-sm-3 pt-md-5 pb-md-3">



<!-- ************************************************ 사이드메뉴 영역 ************************************************ -->
<!-- 사이드메뉴 영역 시작 -->

<!-- 사이드메뉴 영역 끝 -->



<!-- ************************************************ 페이지 영역 ************************************************ -->
<!-- 페이지 영역 시작 -->
<ARTICLE class="d-flex flex-column align-items-start col-lg-8 mx-md-1 mt-xs-2 mt-md-3 pt-2">

	<!-- 제목 영역 시작 -->
	<HEADER class='w-100 mb-1 p-2 px-md-3'>
		<div class='row border-bottom border-secondary border-1'>
			<span class="subject border-bottom border-primary border-5 px-3 fs-1">
			비밀번호 찾기
			</span>
		</div>
	</HEADER>
	<!-- 제목 영역 끝 -->
	<!-- 페이지 내용 시작 -->
	<SECTION class="w-100 pt-0 fs-6">
		<!-- 소단원 제목 -->

		<!-- 소단원 내용 -->
		<!-- 모달 영역. HTML의 가장 처음에 배치해야 한다 -->
<div id="modal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <!-- 모달 제목 영역 -->
            <div class="modal-header">
                <!-- 모달 타이틀 -->
                <h5 class="modal-title">비밀번호 찾기</h5>
                <!-- 모달 닫기 버튼 -->
                <!-- data-bs-dismiss="modal" ← 이 태그속성을 준 엘리먼트에는, 모달을 닫는 역할이 부여되는 것으로 보인다. -->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button>               
            </div>
            <!-- 모달 본문 영역 -->
            <div class="modal-body table table-striped">
                <div>
                    <p class="modal-detail">
						회원님의 임시비밀번호를 이메일로 보내드렸습니다.
                   </p>
                   <div class="buttons">
                   <button onclick="location.href='pwFindMail'">다시찾기</button>
                   <button onclick="location.href='login'">로그인</button>                 
                   </div>
                </div>

            <!-- 모달 꼬리말 영역 -->
        </div>
    </div>
</div>
</div>


		<div class="row p-sm-2 mx-1 mb-5">
			<div class="container">
			<div class="form-group col-12">
				<label for="searchForm_memberId" class="form-label mb-0 id_input">ID</label>
				<input name="memberId" id="memberId" type="text" class="form-control" placeholder="" value="">
				</div>
				<div class="form-group col-12">
				<label for="searchForm_memberId" class="form-label mb-0 id_input">닉네임</label>
				<input name="memberNick" id="memberNick" type="text" class="form-control" placeholder="" value="">
				</div>
				<div class="form-group col-12 mt-3">
				<label for="searchForm_memberId" class="form-label mb-0 id_input">이메일</label>
				<input type="text"  id="idMail" name="email_id" class="input form-control"  placeholder="EMAIL" required>
					@
					<input type="text" id="inputMail" name="email_domain" class="input form-control" required readonly placeholder="EMAIL" >
					<select id="emailBox" name="emailBox" required>
						<option value="" class="pickMail">이메일 선택</option>
						<option value="directly">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="nate.com">nate.com</option>
					</select>				
					</div>
					<!-- 모달 여는 버튼 -->
<!-- 모달 여는 버튼 -->
<button type="button" id="findbtn" class="btn btn-primary m-3 p-3">임시비밀번호 발급하기</button>
			</div>
		</div>
		<!-- 소단원 제목 -->

		<!-- 소단원 내용 -->

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