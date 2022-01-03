package com.kh.hobbycloud.vo.gather;

import java.util.List;
import java.util.Locale.Category;

import lombok.Data;

@Data
public class GatherSearchVO {
	private String gatherLocRegion;
	private String gatherName;
	private List<String>category;
}
