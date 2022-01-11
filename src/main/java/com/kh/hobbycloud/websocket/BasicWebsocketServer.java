package com.kh.hobbycloud.websocket;

/**
 * 기본 웹소켓 서버
 * 	= 상속은 인터페이스 or 클래스 선택하여 받는다
 * 	= 기본 접속은 모두 Spring-Websocket 모듈에서 관리한다
 * 	= 서버로서 반드시 가져야 할 기능들을 재정의하여 웹소켓 사용자들을 관리한다
 * 		= 입장알림(afterConnectionEstablished) - 사용자가 접속한 이후에 사용자의 정보를 알려주는 메소드
 * 		= 퇴장알림(afterConnectionClosed) - 사용자의 접속 종료 이후에 사용자의 정보를 알려주는 메소드
 * 		= 메세지
 */
//@Slf4j
//public class BasicWebsocketServer implements WebSocketHandler{
public class BasicWebsocketServer {//extends TextWebSocketHandler {

	/*@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("사용자가 입장했습니다");
		log.debug("session = {}", session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("사용자가 퇴장했습니다");
		log.debug("session = {}", session);
		log.debug("status = {}", status);
	}*/

}