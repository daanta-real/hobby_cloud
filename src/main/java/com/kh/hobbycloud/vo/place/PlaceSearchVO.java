package com.kh.hobbycloud.vo.place;

import java.util.List;

import lombok.Data;

@Data
public class PlaceSearchVO {
	private String placeSido;
	private String placeName;
	private List<String>category;
}
