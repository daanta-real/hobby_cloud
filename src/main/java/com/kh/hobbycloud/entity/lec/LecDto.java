package com.kh.hobbycloud.entity.lec;

import java.sql.Date;

import lombok.Data;

@Data
public class LecDto {
	private int lecIdx;//강좌idx
	private int tutorIdx;//강사idx
	private String lecCategoryName;//취미 분류 이름
	private int placeIdx;//땅idx
	private String lecName;//강좌 이름
	private String lecDetail;//강좌 상세내용
	private Date lecRegistered;//강좌 작성일
	private int lecPrice;//강좌 수강료
	private int lecHeadCount;//강좌 수강인원
	private int lecContainsCount;//강좌 강의수
	private Date lecStart;//강좌 시작 시간
	private Date lecEnd;//강좌 종료 시간
	private String lecLocRegion;//강좌 주소 지역
	private int lecLocLatitude;//강좌 주소 위도
	private int lecLocLongitude;//강좌 주소 경도
	private int lecEnrolled;//강좌 수강이력수
	private int lecViews;//강좌 조회수
	private int lecReplies;//강좌 댓글수
}
