package com.kh.hobbycloud.entity.place;

import java.sql.Date;

import lombok.Data;

@Data
public class PlaceDto {
	private int placeIdx;
	private int memberIdx;
	private String placeName;
	private String placeDetail;
	private Date placeRegistered;
	private String placeLocRegion;
	private int placeLocLatitude;
	private int placeLocLongitude;
	private Date placeStart;
	private Date placeEnd;
	private int placeMin;
	private int placeMax;
	private String placeEmail;
	private String placePhone;
}





