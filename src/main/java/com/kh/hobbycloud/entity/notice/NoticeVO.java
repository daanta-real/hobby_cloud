package com.kh.hobbycloud.entity.notice;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeVO {
    private int noticeIdx;
	private String noticeName;
	private String noticeDetail;
	private int memberIdx;
	private String memberNick;
	private Date noticeRegistered;
	private int noticeViews;
	private int noticeReplies;

}
