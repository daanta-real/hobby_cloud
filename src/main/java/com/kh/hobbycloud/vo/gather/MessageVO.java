package com.kh.hobbycloud.vo.gather;

import lombok.Data;

@Data
public class MessageVO {
	//사용자가 보내는 정보
	private String content;
	
	//서버가 추가하는 정보
	private String nickname;
	private String time;
}