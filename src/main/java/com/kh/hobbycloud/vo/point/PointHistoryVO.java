package com.kh.hobbycloud.vo.point;

import java.util.Date;

import lombok.Data;

@Data
public class PointHistoryVO {
	private int pointHistoryIdx;
	private int memberIdx;
	private int paidIdx;
	private int pointIdx;
	private Date pointHistoryRegistered;
	private int pointHistoryAmount;
	private String pointHistoryMemo;
	private String memberId;
	private String memberNick;
}
