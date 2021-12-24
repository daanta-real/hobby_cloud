package com.kh.hobbycloud.entity.pay;

import lombok.Data;

// 포인트상품 정보 DTO
@Data
public class Point {
	private Integer pointIdx;   // 포인트상품 idx
	private String pointName;  // 포인트상품 이름
	private Integer pointPrice; // 포인트상품 판매가
	private Integer pointAmount; // 포인트상품 충전액
}





