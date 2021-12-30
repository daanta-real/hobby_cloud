package com.kh.hobbycloud.service.pay;

import com.kh.hobbycloud.vo.pay.KakaoPayApproveRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayVO;

public interface PayService {

	// 카카오페이에게 결제 준비(ready)를 요청한 다음,
	// TID(결제 일련번호와 next_redirect_pc_url(QR코드 주소) 등을 받아와 리턴하는 메소드
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO);

	// 사용자가 QR을 찍은 뒤 tg_token(승인번호)가 입수되면,
	// 카카오페이에게 결제 실행(approve)을 요청하고,
	// 성공한 결제정보를 받아와 리턴하는 메소드
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO);

	// 카카오페이측에 결제정보 조회를 요청하여, 저장된 결제 이력을 리턴하는 메소드
	public KakaoPayVO detail(String tid);

	// 카카오페이측에 결제 취소를 요청한 뒤, 그 결과를 리턴하는 메소드
	public KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO requestVO);

}
