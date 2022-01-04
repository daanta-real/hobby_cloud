package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherDto {
private int gatherIdx ,memberIdx, placeIdx, gatherHeadCount, 
 gatherMax, gatherStaus;
private String lecCategoryName, gatherName, gatherDetail, gatherLocRegion;
private String gatherRegistered, gatherStart,gatherEnd;
//위도 경도를 string으로 바꿈
private String gatherLocLatitude, gatherLocLongitude;
}
