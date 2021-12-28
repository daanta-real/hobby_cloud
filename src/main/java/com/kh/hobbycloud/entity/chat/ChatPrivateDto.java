package com.kh.hobbycloud.entity.chat;

import java.sql.Date;

import lombok.Data;

// 1:1 채팅 기록 DTO
@Data
public class ChatPrivateDto {
	private Integer chatPrivateIdx;		// 기록번호
	private Integer chatPrivateFrom;	// 채팅 발신자 idx
	private Integer chatPrivateTo;		// 채팅 수신자 idx
	private Date chatPrivateRegistered; // 채팅 발생일
	private String chatPrivateDetail;   // 채팅 상세 내용
}
