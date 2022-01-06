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
	private int placePostcode;
	private String placeAddress;
	private String placeDetailAddress;
	private Date placeStart;
	private Date placeEnd;
	private int placeMin;
	private int placeMax;
	private String placeEmail;
	private String placePhone;
	
	//장소사진 테이블
	private int gatherFileIdx;
	
	//member 테이블
	private int memberIdx;

}
