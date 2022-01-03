package com.kh.hobbycloud.vo.pay;

import lombok.Data;

@Data
public class KakaoPayReadyRequestVO {

	// 우리 측 결제 ID 모음
	private String partner_order_id; // 웹사이트 측 결제 일련번호
	private String partner_user_id;  // 회원 아이디

	// 결제 내용 모음
	private String item_name; // 결제 대표 이름
	private int quantity; // 결제 수량
	private long total_amount; // 결제 금액

	// 형변환 메소드 모음
	public String getQuantity_string() {
		return String.valueOf(quantity);
	}
	public String getTotal_amount_string() {
		return String.valueOf(total_amount);
	}

}
