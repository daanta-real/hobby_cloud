package com.kh.hobbycloud.entity.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class LecReviewDto {
	private int lecReviewIdx;
	private int lecIdx;
	private int memberIdx;
	private int lecReviewScore;
	private Date lecReviewRegistered;
	private String lecReviewDetail;
}
