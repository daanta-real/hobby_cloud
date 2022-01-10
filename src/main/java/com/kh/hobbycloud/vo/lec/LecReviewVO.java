package com.kh.hobbycloud.vo.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class LecReviewVO {
	//평점
	private int lecReviewIdx, memberIdx, lecIdx,
	lecReviewScore;
	private String lecReviewDetail; 
	private Date lecReviewRegistered;
	//닉네임
	private String memberNick;
	//프로필 번호
	private int memberProfileIdx;
}
