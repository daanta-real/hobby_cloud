package com.kh.hobbycloud.vo.lec;

import lombok.Data;

/**
 * 강좌의 목록과 검색을 위한 VO
 */
@Data
public class LecListVO {
	private int lecIdx;//강좌 번호
	private String lecCategoryName;//카테고리 이름
	private String lecName;//강좌 이름
	private String memberNick;//강사 이름
	private int lecPrice;//가격
	private int lecHeadCount;//수강 인원
	private int lecContainsCount;//강좌 강의수
}
