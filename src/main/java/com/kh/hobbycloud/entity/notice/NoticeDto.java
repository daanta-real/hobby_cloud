package com.kh.hobbycloud.entity.notice;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeIdx;
	private int memberIdx;
	private String noticeName;
	private String noticeDetail;
	private Date noticeRegistered;
	private int noticeView;
	private int noticeReplies;

}
