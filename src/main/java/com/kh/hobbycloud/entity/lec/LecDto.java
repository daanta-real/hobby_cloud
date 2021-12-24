package com.kh.hobbycloud.entity.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class LecDto {
	private int lecIdx;
	private int tutorIdx;
	private String lecCategoryName;
	private int placeIdx;
	private String lecName;
	private String lecDetail;
	private Date lecRegistered;
	private int lecPrice;
	private int lecHeadCount;
	private int lecContainsCount;
	private Date lecStart;
	private Date lecEnd;
	private String lecLocRegion;
	private int lecLocLatitude;
	private int lecLocLongitude;
	private int lecEnrolled;
	private int lecViews;
	private int lecReplies;
}
