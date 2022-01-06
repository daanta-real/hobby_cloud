package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherReviewDto {
private int gatherReviewIdx, memberIdx, gatherIdx,
gatherReviewScore;
private String gatherReviewDetail; 
private Date gatherReviewRegistered;
}
