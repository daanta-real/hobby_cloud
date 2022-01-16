package com.kh.hobbycloud.vo.notice;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class NoticeFileVO {
	private int noticeIdx;
	private String noticeName;
	private String noticeDetail;
	private int memberIdx;
	private String memberNick;
	private Date noticeRegistered;
	private int noticeViews;
	private int noticeReplies;
	private List<MultipartFile> attach;

}
