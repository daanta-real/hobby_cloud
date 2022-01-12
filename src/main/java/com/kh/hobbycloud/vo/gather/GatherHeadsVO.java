package com.kh.hobbycloud.vo.gather;

import lombok.Data;

// 소모임 게시판과 멤버 관련된 것만 핸들링하기 위한 VO
@Data
public class GatherHeadsVO {

	private int memberIdx, gatherIdx ,gatherStaus;
	//회원 프로필 번호
	private int memberProfileIdx; 
	
	//회원닉네임
	private String memberNick;

}
