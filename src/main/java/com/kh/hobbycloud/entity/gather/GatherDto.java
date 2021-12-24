package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherDto {
private int gatherIdx ,memberIdx, placeIdx, gatherHeadCount, 
gatherLocLatitude, gatherLocLogitude, gatherMax, gatherStaus;
private String lecCategoryName, gatherName, gatherDetail, gatherLocRegion;
private String gatherRegistered, gatherStart,gatherEnd;
}
