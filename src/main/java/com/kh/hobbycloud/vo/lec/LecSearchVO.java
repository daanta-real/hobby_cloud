package com.kh.hobbycloud.vo.lec;

import java.util.List;

import lombok.Data;

@Data
public class LecSearchVO {
	private Integer lecIdx;
	private List<String> lecCategoryName;
	private String lecName;
	private String memberNick;
	private String lecLocRegion;
	private String minPrice;
	private String maxPrice;
	private String minCount;
	private String maxCount;
	private String minConCount;
	private String maxConCount;
}
