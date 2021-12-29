package com.kh.hobbycloud.vo.lec;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 강좌 등록 정보를 받기 위한 VO
 * 강좌정보(MemberDto)와 파일(attach)을 저장한다
 */

@Data
public class LecRegisterVO {
	private int lecIdx;//강좌idx
	private int tutorIdx;//강사idx -> 세션
	private String lecCategoryName;//취미 분류 이름
	private int placeIdx;//땅idx
	private String lecName;//강좌 이름
	private String lecDetail;//강좌 상세내용
	private int lecPrice;//강좌 수강료
	private int lecHeadCount;//강좌 수강인원
	private int lecContainsCount;//강좌 강의수
	private Date lecStart;//강좌 시작 시간
	private Date lecEnd;//강좌 종료 시간
	private String lecLocRegion;//강좌 주소 지역
	private String lecLocLatitude;//강좌 주소 위도
	private String lecLocLongitude;//강좌 주소 경도
	private MultipartFile attach;//파일
}
