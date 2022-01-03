<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<!-- 댓글작성 영역 -->
<div class="board_cmt">
    <div class="tit" style="margin-left: 6px;"><em id="totalCmt" class="bico_comment"></em>Comments</div>
     <div class="board_cmt_write">
         <div class="bx"> 
             <textarea id="cmtContent" placeholder="소중한 댓글을 작성해주세요^^" maxlength="150"></textarea>
         </div>
        <button id="btn_insert_cmt">등록</button>
     </div>
</div>
<!-- 댓글 목록 영역 -->
<div class="board_cmt_list" id="board_cmt_list" style="margin-left:6px;"></div>
<div style="text-align: center; margin: 20px 0px;" id="div_cmt_more">
 <!-- 더보기 글자 hover 띄우기 -->
    <span class="cmt_more_guide" id="cmt_more_guide" style="display: none; position: absolute;"></span>
    <a href='javascript:void(0);' id='btn_cmt_more' style='position: relative;'>
        <img src="/home/img/ico_cmt_more_before.png" id="imgMore" style="cursor:pointer; width: 20px;">
    </a>
</div>
<!-- 더보기 눌렀을때 추가 되는 댓글 영역 -->
<div class="board_cmt_list" id="cmtMore" style="display:none;"></div>
<div style="text-align: center; display:none; margin: 20px 0px;" id="div_cmt_back">
    <span class="cmt_back_guide" id="cmt_back_guide" style="display: none; position: absolute;"></span>
    <a href='javascript:void(0);' id='btn_cmt_back' style='position: relative;'>
        <img src="/home/img/ico_cmt_back_before.png" id="imgBack" style="cursor:pointer; width: 20px;">
    </a>
</div>

<script type="text/javascript">
/* 버튼 세팅 */
 var btn_insert_cmt = document.getElementById("btn_insert_cmt");
 btn_insert_cmt.onclick = function(){insertCmt();}
 /* Model 값 세팅 */
 var idx = ${bbsidx};
 var userid = `${userid}`;
 $(function(){
    //댓글 목록 출력
    selectBBScmt();
     /* 댓글 더보기 화살표 hover */
     $("#btn_cmt_more").hover(function(){
         $("#imgMore").attr("src","/home/img/ico_cmt_more_after.png");
         $("#cmt_more_guide").css("display","");
     }, function(){
         $("#imgMore").attr("src","/home/img/ico_cmt_more_before.png");
         $("#cmt_more_guide").css("display","none");
     });
     /* 댓글 접기 화살표 hover*/
     $("#btn_cmt_back").hover(function(){
         $("#imgBack").attr("src","/home/img/ico_cmt_back_after.png");
         $("#cmt_back_guide").css("display","");
     }, function(){
         $("#imgBack").attr("src","/home/img/ico_cmt_back_before.png");
         $("#cmt_back_guide").css("display","none");
     });
});
//댓글 목록 출력 ajax
  function selectBBScmt(){
     var str1 = ""; //최초 댓글 4개를 append할 변수
     var str2 = ""; //댓글이 5개이상일때 추가 append할 변수
     var strDelAndMod = "";//댓글 수정, 삭제 html string을 담는 변수
     var replyImg = "";//대댓글 이미지 html string을 담는 변수
     var inputWidthClass = "";//대댓글이 달릴때 대댓글의 width값을 담는 변수
     var mlpClass=""; //대댓글이 달릴때 replyImg가 그려질 위치를 정하는 변수
     
      $.ajax({
            type : "POST",  
            url : "/selectBBScmt",       
            dataType : "json",   
            data : "bbscmtidx="+idx,
            error : function(){
                Rnd.alert("통신 에러","error","확인",function(){});
            },
            success : function(jdata) {
                if(jdata.length < 4){ // 댓글이 4개 이하 일때 처음에는 댓글을 최대 4개까지만 보여줌
                    for(var i=0; i<jdata.length; i++){
                        if(userid == jdata[i].userid){
                            //수정 삭제 답글 버튼 본인이 적은거
                            strDelAndMod = "<em onclick=\"cmtModify("+jdata[i].idx+")\" style='cursor:pointer;'>&nbsp;&nbsp;수정</em>&nbsp;<em onclick=\"cmtDelete("+jdata[i].idx+")\" style='cursor:pointer;'>삭제</em>&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        else {
                            strDelAndMod = "&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        if(jdata[i].level > 1){
                            //대댓글 이미지 , input width class 
                            replyImg = "<img src='/home/img/comment_reply.png' class='commentReply'>";
                            inputWidthClass = "class='width96'";
                            if(jdata[i].level == 2){mlpClass = "";}
                            else if(jdata[i].level == 3){mlpClass = "class='mlp30'";}
                            else if(jdata[i].level >= 4){mlpClass = "class='mlp60'";}
                        }
                        else{
                            replyImg = "";
                            inputWidthClass = "class='width100'";
                            mlpClass="";
                        }
                        str1 += "<ul><li><div class='desc'style='border-top: 2px solid black;'>작성날짜&nbsp;<strong>"+jdata[i].regdate+"</strong>&nbsp;&nbsp;작성자&nbsp;<strong>"+jdata[i].userid+"</strong>"
                            +strDelAndMod
                            +"</div></li>"
                            +"<li style='line-height:37px;' "+mlpClass+">"+replyImg
                            +"<input type='text' "+inputWidthClass+"name=\""+jdata[i].idx+"\" value=\""+jdata[i].content+"\" disabled=''style='font-size:15px;font-weight:bold;background-color: #f6f6f6;border: 1px solid #f6f6f6;'></li>"
                            +"<li id=\""+jdata[i].idx+"\" style='display:none;'>"
                            +"<a href='javascript:void(0);' onclick='cmtModCancel(this)' orgcmt=\""+jdata[i].content+"\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"cmtModAri("+jdata[i].idx+")\" class='btn_d btn_build'>완료</a></li>"
                            +"<li id=\""+jdata[i].userid+"_"+jdata[i].idx+"\" style='display:none;'>"
                            +"<img src='/home/img/comment_reply.png' class='commentReply'>"
                            +"<textarea class='replyTextarea' id='"+jdata[i].upidx+"_"+jdata[i].idx+"'></textarea>"
                            +"<div class='replySubmitDiv'>"
                            +"<a href='javascript:void(0);' onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','C')\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"insertReplyCmt('"+jdata[i].upidx+"_"+jdata[i].idx+"','"+jdata[i].bbscmtidx+"')\" class='btn_d btn_build'>등록</a></div></li></ul>";
                        }
                    //댓글 목록 출력
                    $("#board_cmt_list").empty();
                    $("#board_cmt_list").append(str1);
                }
                else{ //댓글이 5개 이상일때 
                    for(var i=0; i<4; i++){//기존 4개 먼저 보여짐
                        if(userid == jdata[i].userid){
                            strDelAndMod = "<em onclick=\"cmtModify("+jdata[i].idx+")\" style='cursor:pointer;'>&nbsp;&nbsp;수정</em>&nbsp;<em onclick=\"cmtDelete("+jdata[i].idx+")\" style='cursor:pointer;'>삭제</em>&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        else {
                            strDelAndMod = "&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        if(jdata[i].level > 1){
                            replyImg = "<img src='/home/img/comment_reply.png' class='commentReply'>";
                            inputWidthClass = "class='width96'";
                            if(jdata[i].level == 2){mlpClass = "";}
                            else if(jdata[i].level == 3){mlpClass = "class='mlp30'";}
                            else if(jdata[i].level >= 4){mlpClass = "class='mlp60'";}
                        }
                        else{
                            replyImg = "";
                            inputWidthClass = "class='width100'";
                            mlpClass="";
                        }
                        str1+= "<ul><li><div class='desc'style='border-top: 2px solid black;'>작성날짜&nbsp;<strong>"+jdata[i].regdate+"</strong>&nbsp;&nbsp;작성자&nbsp;<strong>"+jdata[i].userid+"</strong>"
                            +strDelAndMod
                            +"</div></li>"
                            +"<li style='line-height:37px;' "+mlpClass+">"+replyImg
                            +"<input type='text' "+inputWidthClass+"name=\""+jdata[i].idx+"\" value=\""+jdata[i].content+"\" disabled=''style='font-size:15px;font-weight:bold;background-color: #f6f6f6;border: 1px solid #f6f6f6;'></li>"
                            +"<li id=\""+jdata[i].idx+"\" style='display:none;'>"
                            +"<a href='javascript:void(0);' onclick='cmtModCancel(this)' orgcmt=\""+jdata[i].content+"\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"cmtModAri("+jdata[i].idx+")\" class='btn_d btn_build'>완료</a></li>"
                            +"<li id=\""+jdata[i].userid+"_"+jdata[i].idx+"\" style='display:none;'>"
                            +"<img src='/home/img/comment_reply.png' class='commentReply'>"
                            +"<textarea class='replyTextarea' id='"+jdata[i].upidx+"_"+jdata[i].idx+"'></textarea>"
                            +"<div class='replySubmitDiv'>"
                            +"<a href='javascript:void(0);' onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','C')\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"insertReplyCmt('"+jdata[i].upidx+"_"+jdata[i].idx+"','"+jdata[i].bbscmtidx+"')\" class='btn_d btn_build'>등록</a></div></li></ul>";
                        }
                    for(var i=4; i<jdata.length; i++){ // 더보기 누르면 이미 그려노은거 추가하는거
                        if(userid == jdata[i].userid){
                            strDelAndMod = "<em onclick=\"cmtModify("+jdata[i].idx+")\" style='cursor:pointer;'>&nbsp;&nbsp;수정</em>&nbsp;<em onclick=\"cmtDelete("+jdata[i].idx+")\" style='cursor:pointer;'>삭제</em>&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        else {
                            strDelAndMod = "&nbsp;<em onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','I')\"style='cursor:pointer;'>답글</em>";
                        }
                        if(jdata[i].level > 1){
                            replyImg = "<img src='/home/img/comment_reply.png' class='commentReply'>";
                            inputWidthClass = "class='width96'";
                            if(jdata[i].level == 2){mlpClass = "";}
                            else if(jdata[i].level == 3){mlpClass = "class='mlp30'";}
                            else if(jdata[i].level >= 4){mlpClass = "class='mlp60'";}
                        }
                        else{
                            replyImg = "";
                            inputWidthClass = "class='width100'";
                            mlpClass="";
                        }
                        str2 += "<ul style='margin-left:6px;'><li><div class='desc'style='border-top: 2px solid black;'>작성날짜&nbsp;<strong>"+jdata[i].regdate+"</strong>&nbsp;&nbsp;작성자&nbsp;<strong>"+jdata[i].userid+"</strong>"
                            +strDelAndMod
                            +"</div></li>"
                            +"<li style='line-height:37px;' "+mlpClass+">"+replyImg
                            +"<input type='text' "+inputWidthClass+"name=\""+jdata[i].idx+"\" value=\""+jdata[i].content+"\" disabled=''style='font-size:15px;font-weight:bold;background-color: #f6f6f6;border: 1px solid #f6f6f6;'></li>"
                            +"<li id=\""+jdata[i].idx+"\" style='display:none;'>"
                            +"<a href='javascript:void(0);' onclick='cmtModCancel(this)' orgcmt=\""+jdata[i].content+"\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"cmtModAri("+jdata[i].idx+")\" class='btn_d btn_build'>완료</a></li>"
                            +"<li id=\""+jdata[i].userid+"_"+jdata[i].idx+"\" style='display:none;'>"
                            +"<img src='/home/img/comment_reply.png' class='commentReply'>"
                            +"<textarea class='replyTextarea' id='"+jdata[i].upidx+"_"+jdata[i].idx+"'></textarea>"
                            +"<div class='replySubmitDiv'>"
                            +"<a href='javascript:void(0);' onclick=\"cmtReply('"+jdata[i].userid+"_"+jdata[i].idx+"','C')\" class='btn_d btn_red'>취소</a>&nbsp;"
                            +"<a href='javascript:void(0);' onclick=\"insertReplyCmt('"+jdata[i].upidx+"_"+jdata[i].idx+"','"+jdata[i].bbscmtidx+"')\" class='btn_d btn_build'>등록</a></div></li></ul>";
                        }
                    
                    //처음 댓글 목록 
                    $("#board_cmt_list").empty();
                    $("#board_cmt_list").append(str1);
                    
                    //펼치기 했을때 댓글 목록
                    $("#cmtMore").empty();
                    $("#cmtMore").append(str2);
                    // 더보기 버튼 눌렀을때
                    $("#btn_cmt_more").on("click",function(){
                        $("#div_cmt_more").css("display","none");
                        $("#cmtMore").slideDown();
                        $("#div_cmt_back").css("display","");
                        $("#wrap").animate({ // 스크롤 제일 아래로 애니메이션
                            scrollTop : 10000
                        }, 800);
                    });
                    //접기 버튼 눌렀을때
                    $("#btn_cmt_back").on("click",function(){
                        $("#cmtMore").slideUp(function(){
                            $("#div_cmt_back").css("display","none");
                            $("#div_cmt_more").css("display","");
                        });
                    });
                }
                $("#totalCmt").empty();
                if(jdata.length == 0){
                    totalCmt = 0;
                    $("#imgMore").css("display","none");
                }
                else {
                    $("#imgMore").css("display","");
                    var totalCmt = jdata[0].totalCmt;
                    }
                $("#totalCmt").append(" "+totalCmt+" ");
            }
        });
     }
</script>

<a href="insert">글쓰기</a>
<a href="list">목록보기</a>
<a href="#">수정</a>			
<a href="delete?lecIdx=${lecDetailVO.lecIdx}">삭제</a>	
