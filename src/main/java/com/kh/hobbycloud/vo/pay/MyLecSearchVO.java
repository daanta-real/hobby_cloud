package com.kh.hobbycloud.vo.pay;

import lombok.Data;

@Data
public class MyLecSearchVO {
	private Integer myLecIdx;           // 내 강좌 idx
	private Integer memberIdx;          // 회원 idx
	private Integer memberId;          // 회원 ID
	private Integer memberNick;          // 회원 닉네임
	private Integer lecIdx;             // 강좌 idx
	private Integer pointHistoryIdx;    // 포인트이력 idx
	private String myLecRegistered_start; // 내 강좌 등록일 시작
	private String myLecRegistered_end;   // 내 강좌 등록일 끝
}
