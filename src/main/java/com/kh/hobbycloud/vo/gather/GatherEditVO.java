package com.kh.hobbycloud.vo.gather;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 강좌 수정 정보를 받기 위한 VO
 * 강좌정보(MemberDto)와 파일(attach)을 저장한다
 */

@Data
public class GatherEditVO {
	private int gatherIdx, gatherHeadCount, gatherMax, gatherStatus;
	private String gatherName, gatherDetail;
	// 1-2. 위치 관련
	private String gatherLocRegion;
	private String gatherLocLatitude, gatherLocLongitude;
	// 1-3. 날짜 관련
	private String gatherRegistered, gatherStart, gatherEnd;
	// 3. member 테이블 관련
		private int memberIdx;

		// 4. place 테이블 관련
		private int placeIdx;

		// 5. 취미 분류 관련
		private String lecCategoryName;

	private List<MultipartFile> attach;//파일
	private List<String> fileDelTargetList; // 삭제할 파일 목록 (edit.jsp로부터 받아옴)
}
