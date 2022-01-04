package com.kh.hobbycloud.vo.pay;

import com.kh.hobbycloud.vo.pay.subvo.Amount;

public class KakaoPayCancelResponseVO {

	// 우리 측 결제 ID 모음
	private String cid; //가맹점 코드
	private String partner_order_id; // 웹사이트 측 결제 일련번호
	private String partner_user_id;  // 회원 아이디

	// 카카오측 결제 ID 모음
	private String aid; // 승인 번호 (pg_token은 인증 확인 번호이고 이건 결제 승인 이력 번호임)
	private String tid; // 결제 번호 (카카오측 결제 고유번호)

	// 결제 정보
	private String payment_method_type; // 결제 수단 (CARD = 카드 결제 / MONEY = 현금 결제)
	private Amount amount; // 결제 금액 정보
	private String status; // 결제 상태 (◀ CancelVO에만 있는 값임)
	private String item_name; // 상품 이름
	private String item_code; // 상품 코드
	private int quantity; // 상품 수량
	private String created_at; // 결제 자체의 생성 시각
	private String approved_at; // 결제 최종 승인 시각
	private String canceled_at; // 결제 취소 시각 (◀ CancelVO에만 있는 값임)
	private String payload; // 추가로 메모된 사항

}
