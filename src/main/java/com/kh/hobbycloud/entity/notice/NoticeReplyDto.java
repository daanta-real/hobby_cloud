package com.kh.hobbycloud.entity.notice;

import lombok.Data;

@Data
public class NoticeReplyDto {
	private int noticeReplyIdx;
	private int memberIdx;
	private int noticeIdx;
	private String noticeReplyDetail;
	private String noticeReplyRegistered;
	private int noticeReplySuperno;
	private int noticeReplyGroupno;
	private int noticeReplyDepth;

}
