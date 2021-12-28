package com.kh.hobbycloud.entity.gather;

import java.sql.Date;

import lombok.Data;

@Data
public class GatherReplyDto {
private int GatherReplyIdx, MemberIdx,GatherIdx,GatherReplySuperIdx,GatherGroupNo, GatherReplyDepth;
private String GatherReplyDetail;
private Date GatherReplyDate;
}
