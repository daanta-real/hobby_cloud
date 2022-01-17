package com.kh.hobbycloud.vo.point;

import java.util.Date;

import lombok.Data;

@Data
public class PointHistorySearchVO {
	private Integer memberIdx;               // 관련 회원번호
	private Integer pointHistoryIdx;         // 포인트 증감이력 idx
	private Integer paidIdx;                 // 관련 결제이력 idx (null 가능)
	private Integer pointIdx;                // 관련 포인트상품 idx (null 가능)
	private Date pointHistoryRegistered_start; // 포인트 변동일시 (첫 날짜)
	private Date pointHistoryRegistered_end; // 포인트 변동일시 (마지막 날짜)
	private Integer pointHistoryAmount_min;  // 포인트 변동량 최소
	private Integer pointHistoryAmount_max;  // 포인트 변동량 최대
	private String pointHistoryMemo;         // 포인트 변동이력메모
}