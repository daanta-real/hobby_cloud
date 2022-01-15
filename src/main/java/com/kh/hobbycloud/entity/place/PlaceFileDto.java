package com.kh.hobbycloud.entity.place;

import lombok.Data;

@Data
public class PlaceFileDto {
	
	private int PlaceFileIdx;
	private int PlaceIdx;
	private String PlaceFileUserName;
	private String PlaceFileServerName;
	private long PlaceFileSize;
	private String PlaceFileType;

}
