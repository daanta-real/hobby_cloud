<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.panel {
		position:fixed;
		top:50px;
		right:50px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	//목표 : 연결버튼을 누르면 웹소켓연결, 종료버튼을 누르면 웹소켓종료를 하도록 구현
	$(function(){
		
		disconnectOperation();
		
		//연결을 시작하자마자 별도의 이벤트 없이 시도
		//주소를 직접 작성하지 말고 계산하도록 구현
		var uri = "ws://";
		uri += location.host;
		uri += "${pageContext.request.contextPath}";
		uri += "/memberServer";
		
		window.socket = new WebSocket(uri);
		console.log(socket);
		
		//콜백(예약코드)함수 설정
		socket.onopen = function(){
			connectOperation();
		};
		socket.onclose = function(){
			disconnectOperation();				
		};
		socket.onerror = function(){
			disconnectOperation();
		};
		//메세지 수신부 : 서버에서 오는 메세지를 받아서 화면에 원하는대로 출력(알림, 태그생성)
		socket.onmessage = function(message){
			console.log(message);
			
			//자바스크립트에서는 JSON 관련 처리를 JSON 모듈이 한다.
			//= from 객체 to 문자열 : JSON.stringify()
			//= from 문자열 to 객체 : JSON.parse()
			var obj = JSON.parse(message.data);
			console.log(obj);
			
			var tag = $("<pre>");
			
			tag.append("["+obj.nickname+"]\n");
			tag.append(obj.content);
			tag.append("("+obj.time+")");
			$(".result").append(tag);
			
			//스크롤을 바닥으로 이동
			$("body").scrollTop($(document).height());
		};
		
		//전송버튼
		//= 전송버튼을 누르면 다음 형태의 데이터를 생성하여 전송
		//= {"nickname":"???", "content":"???"}
		$(".send-btn").click(function(){
			var obj = {
				content:$(".user-input").val()
			};
			
			if(!obj.content) return;
			
			//자바스크립트에서는 JSON 관련 처리를 JSON 모듈이 한다.
			//= from 객체 to 문자열 : JSON.stringify()
			//= from 문자열 to 객체 : JSON.parse()
			var text = JSON.stringify(obj);
			console.log(text);
			
			window.socket.send(text);//전송 가능(문자열)
			
			$(".user-input").val("");
		});
		
	});
	
	function connectOperation(){//연결 시 화면 처리
		$(".connect-btn").prop("disabled", true);
		$(".disconnect-btn").prop("disabled", false);
		$(".user-nickname").prop("disabled", false);
		$(".user-input").prop("disabled", false);
		$(".send-btn").prop("disabled", false);
	}
	function disconnectOperation(){//종료 시 화면 처리
		$(".connect-btn").prop("disabled", false);
		$(".disconnect-btn").prop("disabled", true);
		$(".user-nickname").prop("disabled", true);
		$(".user-input").prop("disabled", true);
		$(".send-btn").prop("disabled", true);
	}
	
	//화면이 로딩 해제될 때 웹소켓 종료 시도
	$(window).on("beforeunload", function(){
		if(window.socket){
			window.socket.close();
		}
	});
</script>
    
<div class="panel">
	<h1>MemberWebsocket 예제</h1>
	<h2>현재 아이디 : ${memberIdx}</h2>
	<c:choose>
		<c:when test="${memberIdx != null}">
			<textarea class="user-input" cols="60" rows="5" placeholder="메세지"></textarea>
			<br>
			<button class="send-btn">전송</button>
		</c:when>
		<c:otherwise>
			<textarea cols="60" rows="5" placeholder="로그인 후 이용하세요" disabled></textarea>
			<br>
			<button disabled>전송</button>
		</c:otherwise>
	</c:choose>
</div>

<div class="result"></div>