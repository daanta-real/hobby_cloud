package com.kh.hobbycloud.vo.lec;

import lombok.Data;

@Data
public class LecLikeVO {
	private int lecIdx;
	private int memberIdx;
	private int isLike;//좋아요 체크위한 값(누르면 1, 취소하면 0)
	
	private int count;//좋아요가 눌린 상태인지 아닌지
	private int allIsLike;//좋아요 수
}
