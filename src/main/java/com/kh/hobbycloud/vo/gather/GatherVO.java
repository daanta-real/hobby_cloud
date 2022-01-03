package com.kh.hobbycloud.vo.gather;

import lombok.Data;

// 소모임 게시판과 멤버 관련된 것만 핸들링하기 위한 VO
@Data
public class GatherVO {

	// 1. gather 테이블 관련
	// 1-1. 일반
	private int gatherIdx, gatherHeadCount, gatherMax, gatherStatus;
	private String gatherName, gatherDetail;
	// 1-2. 위치 관련
	private String gatherLocRegion;
	private int gatherLocLatitude, gatherLocLongitude;
	// 1-3. 날짜 관련
	private String gatherRegistered, gatherStart, gatherEnd;

	// 2. gather_file 테이블 관련
	private int gatherFileIdx;

	// 3. member 테이블 관련
	private int memberIdx;
	private String memberNick;

	// 4. place 테이블 관련
	private int placeIdx;

	// 5. 취미 분류 관련
	private String lecCategoryName;

}
