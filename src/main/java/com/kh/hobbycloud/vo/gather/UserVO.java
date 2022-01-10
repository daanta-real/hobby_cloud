package com.kh.hobbycloud.vo.gather;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
//@EqualsAndHashCode(of = {"userId", "session"})
public class UserVO {
	
	
	private String memberIdx;
	
	private WebSocketSession session;

}