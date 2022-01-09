package com.kh.hobbycloud.vo.gather;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
//@EqualsAndHashCode(of = {"userId", "session"})
public class UserVO {
	private String userId;
	private WebSocketSession session;
	
	public boolean isMember() {
		return userId != null;
	}
	public boolean isGuest() {
		return userId == null;
	}
}