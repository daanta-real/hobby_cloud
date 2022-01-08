package com.kh.hobbycloud.vo.place;

import java.sql.Date;

import lombok.Data;

@Data
public class PlaceListVO {
	
	//장소 테이블
	private int placeIdx;//장소번호
	private String placeName;//장소 이름
	private Date placeRegistered;//장소 등록일
	private String placePostcode;//장소 우편번호
	private String placeAddress;//장소 주소
	private Date placeStart;//장소 대여시작일
	private Date placeEnd;//장소 대여 마감일
	private int placeMin;//장소 최소금액
	private int placeMax;//장소 최대금액
	private String placeEmail;//장소 이메일
	private String placePhone;//장소 번호
	
	//땅주인 이름
	private String memberNick;
	
	//카테고리 이름
	private String lecCategoryName;

}
