package com.kh.hobbycloud.vo.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class MyLecVO {
	private int lecMyIdx;
	private int lecIdx;
	private String lecName;
	private String lecLocRegion;
	private int lecContainsCount;
	private Date lecStart;//강좌 시작 날짜
	private Date lecEnd;//강좌 종료 날짜
	private String lecCategoryName;//취미 분류 이름
	private String memberNick;//강사 이름
}
