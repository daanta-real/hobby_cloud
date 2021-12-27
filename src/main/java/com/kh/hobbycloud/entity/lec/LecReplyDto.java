package com.kh.hobbycloud.entity.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class LecReplyDto {
	private int lecReplyIdx;
	private int memberIdx;
	private int lecIdx;
	private String lecReplyDetail;
	private Date lecReplyRegistered;
	private int lecReplySuperidx;
	private int lecReplyGroupno;
	private int lecReplyDepth;
}
