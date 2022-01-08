package com.kh.hobbycloud.vo.place;

import java.sql.Date;

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
	
	//장소사진 테이블
	private int placeFileIdx;
	
	//member 테이블
	private int memberIdx;
	
	//취미 분류 이름
	private String lecCategoryName;

}
