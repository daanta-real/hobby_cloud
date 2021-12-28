package com.kh.hobbycloud.vo.notice;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

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
	private MultipartFile attach;

}
