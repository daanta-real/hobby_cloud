package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherReplyDto {
private int gatherReplyIdx, memberIdx,gatherIdx,gatherReplySuperIdx,gatherGroupNo, gatherReplyDepth;
private String gatherReplyDetail;
private Date gatherReplyDate;
}
