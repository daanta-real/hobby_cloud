package com.kh.hobbycloud.vo.notice;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class NoticeEditVO {
	private int noticeIdx;
	private String noticeName;
	private String noticeDetail;
	private int memberIdx;
	private String memberNick;
	private Date noticeRegistered;
	private int noticeViews;
	private int noticeReplies;
	private List<MultipartFile> attach;
	private List<String> fileDelTargetList; // 삭제할 파일 목록 (edit.jsp로부터 받아옴)

}
