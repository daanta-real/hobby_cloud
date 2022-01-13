package com.kh.hobbycloud.entity.point;

import java.util.Date;

import lombok.Data;

//포인트 변동이력 DTO
@Data
public class PointHistoryDto {
	private Integer pointHistoryIdx;     // 포인트 증감이력 idx (기본 지정)
	private Integer memberIdx;           // 회원 idx
	private Integer paidIdx;             // 관련 결제이력 idx (null 가능)
	private Integer pointIdx;            // 관련 포인트상품 idx (null 가능)
	private Date pointHistoryRegistered; // 포인트 변동일시
	private Integer pointHistoryAmount;  // 포인트 변동량 (±)
	private String pointHistoryMemo;     // 포인트 변동이력메모
}