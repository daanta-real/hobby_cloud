package com.kh.hobbycloud.vo.notice;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class NoticeFileVO {
	private int noticeIdx;
	private int memberIdx;
	private String noticeName;
	private String noticeDetail;
	private Date noticeRegistered;
	private int noticeView;
	private int noticeReplies;
	private MultipartFile attach;

}
