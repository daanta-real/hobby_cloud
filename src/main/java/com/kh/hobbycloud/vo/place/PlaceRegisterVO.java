package com.kh.hobbycloud.vo.place;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PlaceRegisterVO {
	
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
	private String placeSido;
	private String placeSigungu;
	private String placeBname;
	private String placeLocLatitude;
	private String placeLocLongitude;
	
	//장소사진 테이블
	private int placeFileIdx;
	List<MultipartFile> attach; // 추가될 첨부파일들 정보 객체
	
	//member 테이블
	private int memberIdx;
	
	//취미 분류 이름
	private String lecCategoryName;
}
