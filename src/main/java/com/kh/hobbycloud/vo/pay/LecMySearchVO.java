package com.kh.hobbycloud.vo.pay;

import java.util.Date;

import com.kh.hobbycloud.util.CommonUtils;

import lombok.Data;

@Data
public class LecMySearchVO {

	// paid테이블 계열
	private Integer paidIdx;      // 결제이력 idx
	private Integer memberIdx;    // 회원 idx
	private String paidTid;       // 결제 tid
	private Date paidRegistered;  // 결제 일시
	private String paidRegisteredStr; // 결제 일시 String 버전
	private Integer paidPrice;    // 결제 금액(원)
	private Character paidStatus; // 결제 상태

	// member 테이블 계열
	private String memberId;
	private String memberNick;

	// 결제 상태 관련 조작 메소드
	public boolean getPaidStatus() { return paidStatus == '1'; } // 1 = 성공, 0 = 취소됨
	void setPaidStatus(boolean status) { this.paidStatus = status ? '1' : '0'; } // true = 성공처리, false = 실패처리

	// 데이터 관련 조작 메소드
	public void prepareDateStr() {
		this.paidRegisteredStr = CommonUtils.toChar(this.paidRegistered);
	}

}
