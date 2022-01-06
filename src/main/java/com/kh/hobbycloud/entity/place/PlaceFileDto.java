package com.kh.hobbycloud.entity.place;

import lombok.Data;

@Data
public class PlaceFileDto {
	
	private int PlaceFileIdx, PlaceIdx;
	private String PlaceFileUserName, PlaceFileServerName, PlaceFileType;
	private long PlaceFileSize;

}
