package com.kh.hobbycloud.entity.pay;

import java.sql.Date;

import lombok.Data;

// 결제이력 DTO
@Data
public class PaidDto {
	private Integer paidIdx;     // 결제이력 idx
	private Integer memberIdx;   // 회원 idx
	private String paidTid;      // 결제 tid
	private Date paidRegistered; // 결제 일시
	private Integer paidPrice;   // 결제 금액(원)
}





