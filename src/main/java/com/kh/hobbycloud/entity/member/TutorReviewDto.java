package com.kh.hobbycloud.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class TutorReviewDto {
	private int tutorReviewIdx;
	private int memberIdx;
	private int tutorIdx;
	private int tutorReviewScore;
	private Date tutorReviewRegistered;
	private String tutorReviewDetail;
}
