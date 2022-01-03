package com.kh.hobbycloud.vo.pay;

import lombok.Data;

@Data
public class KakaoPayApproveRequestVO {

	// 우리 측 결제 ID 모음
	private String partner_order_id; // 웹사이트 측 결제 ID
	private String partner_user_id;  // 유저 측 결제 ID

	// 카카오페이측에서 쓰는 변수들 모음
	private String tid; // 카카오페이측에서 갖고 있을 결제 ID
	private String pg_token; // 결제 승인 일련번호

}
