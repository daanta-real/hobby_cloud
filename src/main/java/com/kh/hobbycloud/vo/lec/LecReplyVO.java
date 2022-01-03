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
	private int lecReplySuperidx;//상위글(parent)
	private int lecReplyGroupno;//댓글 그룹 번호(originNo)
	private int lecReplyDepth;//그룹 내 댓글 깊이(댓글, 대댓글 판단)
												//(groupLayer(계층))
	private int lecReplyOrder;
}
//Depth - parent_reply_idx의 depth + 1
//Order - parent_reply_idx를 처음으로 갖는다면
//				parent의 Order + 1
//				그러나 parent_reply_idx가 이미 존재하면
//				존재하는 값들의 max(order)+1
//				order 넘버보다 크거나 같은 값들은 모두 +1 시킨다.


////	private String timeGap;//registered와 현재시간과의 차이
//	
////	private String memberProfileUrl;//멤버 프로필 불러올 url
//	//어떻게 불러올지 모르겠음
//}
