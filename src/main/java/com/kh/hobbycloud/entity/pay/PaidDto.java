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
	private Character paidStatus;   // 결제 금액(원)

	boolean getStatus() { return paidStatus == '1'; } // 1 = 성공, 0 = 취소됨
	void setStatus(boolean status) { this.paidStatus = status ? '1' : '0'; } // true = 성공처리, false = 실패처리

}





