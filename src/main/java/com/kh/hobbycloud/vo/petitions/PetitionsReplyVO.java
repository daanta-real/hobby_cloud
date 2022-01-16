package com.kh.hobbycloud.vo.petitions;

import java.sql.Date;

import lombok.Data;

@Data
public class PetitionsReplyVO {
	//게시판 댓글을 가져오기 위한 VO
	
		private int petitionsReplyIdx, memberIdx,petitionsIdx;
		private String petitionsReplyDetail;
		private Date petitionsReplyRegistered;
		//닉네임
		private String memberNick;

}
