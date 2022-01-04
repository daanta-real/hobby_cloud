package com.kh.hobbycloud.vo.lec;

import java.sql.Date;

import lombok.Data;

/**
 * 강좌의 상세 정보 출력을 위한 VO
 */
@Data
public class LecDetailVO {
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
	private Date lecStart;//강좌 시작 날짜
	private Date lecEnd;//강좌 종료 날짜
	private String lecLocRegion;//강좌 주소 지역
	private String lecLocLatitude;//강좌 주소 위도
	private String lecLocLongitude;//강좌 주소 경도
	private int lecEnrolled;//강좌 수강이력수
	private int lecViews;//강좌 조회수
	private int lecReplies;//강좌 댓글수
	private String tutorDetail;//강사 소개
	private Date tutorRegistered;//강사 등록일
	private String memberNick;//강사 이름
	private String memberEmail;//강사 이메일
	private String memberPhone;//강사 번호
	private String placeName;//장소 이름
	private String placeDetail;//장소 소개
	private int lecLike;//좋아요수
//	private String placeLocLatitude;//장소 위도
//	private String placeLocLongitude;//장소 경도
}
