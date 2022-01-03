package com.kh.hobbycloud.vo.gather;

import java.sql.Date;

import lombok.Data;



@Data
public class GatherReplyVO {
//게시판 댓글을 가져오기 위한 VO
	
	private int gatherReplyIdx, memberIdx,gatherIdx,gatherReplySuperIdx,gatherGroupNo, gatherReplyDepth;
	private String gatherReplyDetail;
	private Date gatherReplyDate;
	//닉네임
	private String memberNick;
}
