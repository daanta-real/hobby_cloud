<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	//목표 : 연결버튼을 누르면 웹소켓연결, 종료버튼을 누르면 웹소켓종료를 하도록 구현
	$(function(){
		
		disconnectOperation();
		
		//연결버튼
		$(".connect-btn").click(function(){
			
			//접속 주소 설정(주소가 ws로 시작하며 생략이 불가하다)
			//= 아무 기술이 적용되지 않았을 때는 페이지와 주소가 달라야 한다
			var uri = "ws://localhost:8080/hobbycloud/basicServer";
			
			//접속
			//= window 객체에 socket이라는 변수를 신규 생성해서 websocket 연결 정보를 저장
			//= 현재 페이지에서는 동일한 window 객체를 사용하므로 모두 접근 가능하게 된다(window.socket)
			//= window는 생략이 가능하므로 그냥 socket 이라고 부를 수 있다
			//window.socket = new WebSocket(uri);
			socket = new WebSocket(uri);
			
			connectOperation();
		});
		
		//종료버튼
		$(".disconnect-btn").click(function(){
			//window.socket.close();
			socket.close();
			
			disconnectOperation();
		});
		
	});
	
	function connectOperation(){//연결 시 화면 처리
		$(".connect-btn").prop("disabled", true);
		$(".disconnect-btn").prop("disabled", false);
	}
	function disconnectOperation(){//종료 시 화면 처리
		$(".connect-btn").prop("disabled", false);
		$(".disconnect-btn").prop("disabled", true);
	}
</script>
    
<h1>BasicWebsocket 예제</h1>

<button class="connect-btn">연결</button>
<button class="disconnect-btn">종료</button>

