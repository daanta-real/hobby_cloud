package com.kh.hobbycloud.vo.pay.subvo;

import lombok.Data;

// 금액 관련된 데이터들을 모아놓는 VO
@Data
public class Amount {

	private int total;    // 전체 결제 금액
	private int tax_free; // 비과세 금액
	private int vat;      // 부가세 금액
	private int point;    // 사용한 포인트 금액
	private int discount; // 할인된 금액

}
