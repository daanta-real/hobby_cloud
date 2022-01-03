package com.kh.hobbycloud.vo.pay.subvo;

import lombok.Data;

// 결제 그 자체에 대한 서브정보

@Data
public class PaymentActionDetails {
	private String aid;                 // 요청(Request) 고유번호
	private String approved_at;         // 거래시간
	private int amount;                 // 결제/취소 총액
	private int point_amount;           // 결제/취소 포인트 총액
	private int discount_amount;        // 할인 금액
	private String payment_action_type; // 결제 타입(PAYMENT/CANCEL/ISSUED_SID)
	private String payload;             // request로 전달한 값(메모)
}
