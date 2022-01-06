package com.kh.hobbycloud.vo.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherReviewVO {
	//평점
	private int gatherReviewIdx, memberIdx, gatherIdx,
	gatherReviewScore;
	private String gatherReviewDetail; 
	private Date gatherReviewRegistered;
	//닉네임
	private String memberNick;
	//프로필 번호
	private int memberProfileIdx;
}
