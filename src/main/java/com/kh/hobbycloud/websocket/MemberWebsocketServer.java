package com.kh.hobbycloud.websocket;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.hobbycloud.vo.gather.MessageVO;
import com.kh.hobbycloud.vo.gather.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MemberWebsocketServer extends TextWebSocketHandler{
	
	//기존 : 웹소켓 정보만 저장(회원정보 접근이 어려움)
	//private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	//변경 : 아이디(String)와 웹소켓정보(WebSocketSession)를 묶어서 저장
	private Set<UserVO> users = new CopyOnWriteArraySet<>();
	
	@Autowired
	private ObjectMapper mapper;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("session = {}", session);
		log.debug("attributes = {}", session.getAttributes());//인터셉터 등으로 추가된 데이터가 존재하는 위치
		log.debug("userId = {}", session.getAttributes().get("memberIdx"));
		
		String memberIdx = (String) session.getAttributes().get("memberIdx");
		
		UserVO user = new UserVO();
		user.setUserId(memberIdx);
		user.setSession(session);
		
		users.add(user);
		log.debug("{} 접속 = {}명", user.getUserId(), users.size());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("session = {}", session);
		log.debug("attributes = {}", session.getAttributes());//인터셉터 등으로 추가된 데이터가 존재하는 위치
		log.debug("userId = {}", session.getAttributes().get("memberIdx"));
		
		String memberIdx = (String) session.getAttributes().get("memberIdx");
		
		UserVO user = new UserVO();
		user.setUserId(memberIdx);
		user.setSession(session);
		
		users.remove(user);
		log.debug("{} 종료 = {}명", user.getUserId(), users.size());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//사용자는 메세지의 내용만 작성해서 JSON String으로 보낸다
		//서버에서는 메세지를 수신한 다음 session에서 아이디를 꺼내 회원인지 확인해서 회원이라면 broadcast 진행
		
		//사용자의 ID를 꺼낸다(비회원이면 null)
		String memberIdx = (String) session.getAttributes().get("memberIdx");
		if(memberIdx == null) return;		
		
		//메세지 수신
		MessageVO vo = mapper.readValue(message.getPayload(), MessageVO.class);
		vo.setNickname(memberIdx);
		
		//java 1.8부터 등장한 java.time 패키지의 코드를 이용하여 시간 정보 생성
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a h:mm");
		vo.setTime(formatter.format(now));
		
		//메세지 생성
		TextMessage newMessage = new TextMessage(mapper.writeValueAsString(vo));
		
		//전체 발송(broadcast)
		for(UserVO user : users) {
			user.getSession().sendMessage(newMessage);
		}
	}
	
}


