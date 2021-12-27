package com.kh.hobbycloud.entity.chat;

import java.sql.Date;

import lombok.Data;

// 채널 채팅 기록 DTO
@Data
public class ChatChannelDto {
	private Integer chatChannelIdx;     // 기록번호
	private Integer chatChannelFrom;    // 채팅 발신자 idx
	private Date chatChannelRegistered; // 채팅 발생일
	private String chatChannelDetail;   // 채팅 상세 내용
}





