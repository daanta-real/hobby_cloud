package com.kh.hobbycloud.vo.place;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 *  수정 정보를 받기 위한 VO
 * 강좌정보(MemberDto)와 파일(attach)을 저장한다
 */
@Data
public class PlaceEditVO {
	
	//장소 테이블
	private int placeIdx;
	private String placeName;
	private String placeDetail;
	private Date placeRegistered;
	private String placePostcode;
	private String placeAddress;
	private String placeDetailAddress;
	private Date placeStart;
	private Date placeEnd;
	private int placeMin;
	private int placeMax;
	private String placeEmail;
	private String placePhone;
	
	//장소사진 테이블
	private List<MultipartFile> attach;
	
	//member 테이블
	private int memberIdx;
	
	// 삭제할 파일 목록 (edit.jsp로부터 받아옴)
	private List<String> placeFileDelTargetList; 

}
