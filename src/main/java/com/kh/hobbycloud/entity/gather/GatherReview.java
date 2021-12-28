package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherReview {
private int GatherReviewIdx, MemberIdx, GatherIdx,
GatherReviewScore;
private String GatherReviewDetail; 
private Date GatherReviewRegistered;
}
