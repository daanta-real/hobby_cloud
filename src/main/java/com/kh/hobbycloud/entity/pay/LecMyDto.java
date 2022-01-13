package com.kh.hobbycloud.entity.pay;

import java.sql.Date;

import lombok.Data;

// 내 강좌 목록 DTO
@Data
public class LecMyDto {
	private Integer lecMyIdx;        // 내 강좌 idx
	private Integer memberIdx;       // 회원 idx
	private Integer lecIdx;			 // 강좌 idx
	private Integer pointHistoryIdx; // 포인트이력 idx
	private Date lecMyRegistered;    // 내 강좌 등록일
}
