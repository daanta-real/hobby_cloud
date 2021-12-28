package com.kh.hobbycloud.vo.gather;

import lombok.Data;

@Data
public class GatherVO {
	private int gatherIdx ,memberIdx, placeIdx, gatherHeadCount, 
	gatherLocLatitude, gatherLocLogitude, gatherMax, gatherStaus;
	private String lecCategoryName, gatherName, gatherDetail, gatherLocRegion;
	private String gatherRegistered, gatherStart,gatherEnd;
	private String memberNick;
	private int gatherFileIdx;
}
