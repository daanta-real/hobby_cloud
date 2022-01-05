package com.kh.hobbycloud.vo.gather;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GatherFileVO {

	// 1. gather 테이블 관련
	// 1-1. 일반
	private int gatherIdx, gatherHeadCount, gatherMax, gatherStatus;
	private String gatherName, gatherDetail;
	// 1-2. 위치 관련
	private String gatherLocRegion;
	private String gatherLocLatitude, gatherLocLongitude;
	// 1-3. 날짜 관련
	private String gatherRegistered, gatherStart, gatherEnd;

	// 2. gather_file 테이블 관련
	private List<MultipartFile> attach;

	// 3. member 테이블 관련
	private int memberIdx;

	// 4. place 테이블 관련
	private int placeIdx;

	// 5. 취미 분류 관련
	private String lecCategoryName;

}
