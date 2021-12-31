package com.kh.hobbycloud.vo.lec;

import lombok.Data;

@Data
public class LecReplyVO {
	private int lecReplyIdx;
	private int memberIdx;
	private int lecIdx;
	
	private String memberNick;//작성자 닉네임
	
	private String lecReplyDetail;
	private String lecReplyRegistered;
	private int lecReplySuperidx;//그룹 내 댓글 순서
	private int lecReplyGroupno;//댓글 그룹 번호
	private int lecReplyDepth;//그룹 내 댓글 깊이(댓글, 대댓글 판단)
	
//	private String timeGap;//registered와 현재시간과의 차이
	
//	private String memberProfileUrl;//멤버 프로필 불러올 url
	//어떻게 불러올지 모르겠음
}
