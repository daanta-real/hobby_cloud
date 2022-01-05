package com.kh.hobbycloud.vo.notice;

import java.sql.Date;

import lombok.Data;
@Data
public class NoticeReplyVO {
	private int noticeReplyIdx;
	private int noticeIdx;
	private String noticeReplyDetail;
	private Date noticeReplyRegistered;
	private int memberIdx;
	private String memberNick;
	

}
