package com.kh.hobbycloud.entity.pay;

import lombok.Data;

// 포인트 변동이력 DTO
@Data
public class PointHistoryDto {
	private Integer pointHistoryIdx;    // 포인트이력 idx
	private Integer paidIdx;			// 결제이력 idx
	private Integer pointIdx;           // 포인트상품 idx
	private Integer pointHistoryAmount; // 포인트이력 변동량 (±)
	private String pointHistoryMemo;    // 포인트이력 변동이력메모
}





