package com.kh.hobbycloud.service.pay;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@SuppressWarnings("serial")
public class PayServiceImpl implements PayService {

	// 변수준비: 카카오페이 어드민 키 및 업체ID
	@Autowired private String KAKAOPAY_ADMIN_KEY;
	@Autowired private String KAKAOPAY_CID;
	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명
	// 변수준비: DAO 계열
	@Autowired PointHistoryDao pointHistoryDao;
	@Autowired PaidDao paidDao;

	// 자체 메소드 2. 새 헤더 인스턴스를 생성해 리턴하는 메소드
	private HttpHeaders header() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", KAKAOPAY_ADMIN_KEY);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		return headers;
	}

	// 자체 메소드 3. POST 후 Object로 회신
	private <T> T sendPost(LinkedMultiValueMap<String, String> body, String kakaoTarget, Class<T> targetClass)
			throws RestClientException, URISyntaxException {
		body.add("cid", KAKAOPAY_CID);
		return new RestTemplate().postForObject(
			// REST POST 정보 1. 접속할 카카오페이 주소
			new URI("https://kapi.kakao.com/v1/payment/" + kakaoTarget),
			// REST POST 정보 2. HTTP 헤더 및 바디 엔티티 모음
			new HttpEntity<>(body, header()),
			// REST POST 정보 3. 반환받을 자료형
			targetClass
		);
	}

	// 카카오페이에게 결제 준비(ready)를 요청한 다음,
	// TID(결제 일련번호)와 next_redirect_pc_url(QR코드 주소) 등을 받아와 리턴하는 메소드
	@Override
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO, HttpServletRequest request) throws URISyntaxException {
		return sendPost(
			new LinkedMultiValueMap<String, String>() {{
				// 필요정보 1. 업체측과 사용자측의 결제 코드
				add("partner_order_id", requestVO.getPartner_order_id()); // 가맹점 측에서 갖고 있을 주문번호
				add("partner_user_id", requestVO.getPartner_user_id()); // 유저 측에서 갖고 있을 주문번호
				// 필요정보 2. 주요 결제정보 등록
				add("item_name", requestVO.getItem_name()); // 대표상품 제목
				add("quantity", requestVO.getQuantity_string()); // 결제 건수 (웬만하면 1)
				add("total_amount", requestVO.getTotal_amount_string()); // 최종 구매 금액 (test계정이라 100 넘으면 안 됨)
				add("tax_free_amount", "0"); // 면세 부분. 미활용 예상됨
				// 필요정보 3. 카카오서버에게 결제 결과에 따른 페이지를 미리 안내
				// 카카오 개발자 페이지의 애플리케이션에 등록된 주소만 가능하므로 사전 등록 여부 필히 확인
				// 아래 세 개의 페이지가 미리 준비되어 있어야 결제 자체가 가능하다.
				add("approval_url", SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/pay/success");
				add("cancel_url", SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/pay/cancel");
				add("fail_url", SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/pay/fail");
			}}, "ready", KakaoPayReadyResponseVO.class
		);
	}

	// 사용자가 QR을 찍은 뒤 tg_token(승인번호)가 입수되면,
	// 카카오페이에게 결제 실행(approve)을 요청하고,
	// 성공한 결제정보를 받아와 리턴하는 메소드
	@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO) throws RestClientException, URISyntaxException {
		return sendPost(
			new LinkedMultiValueMap<String, String>() {{
				// 필요정보 1. 업체측과 사용자측의 결제 코드, 카카오측의 결제 ID
				add("partner_order_id", requestVO.getPartner_order_id()); // 가맹점 측에서 갖고 있을 주문번호
				add("partner_user_id", requestVO.getPartner_user_id()); // 유저 측에서 갖고 있을 주문번호
				add("tid", requestVO.getTid()); // 카카오페이측에서 갖고 있을 결제 ID
				// 필요정보 2. pg_token(결제 승인 일련번호)
				add("pg_token", requestVO.getPg_token()); // 결제 승인 일련번호
			}}, "approve", KakaoPayApproveResponseVO.class
		);
	}
	/*
	// 결제가 모두 끝나면, 결제 이력을 DB의 point_history, paid 테이블에 각각 기록하고,
	// member 테이블의 point 수량을 변경 반영해 주는 메소드
	@Override
	public boolean addRecord(PayRecordVO vo) {

		// 1. 결제된 이력을 DTO로 만들어 paid 테이블에 insert시키고
		// 결제한 만큼 회원의 포인트 소유량 변경 적용
		PaidDto paidDto = new PaidDto();
		paidDto.setPaidIdx(vo.getPaidIdx());
		paidDto.setMemberIdx(vo.getMemberIdx());
		paidDto.setPaidTid(vo.getTid());
		paidDto.setPaidIdx(vo.getPaidIdx());
		paidDto.setPaidName(vo.getName());
		paidDto.setPaidPrice(vo.getPrice());
		paidDao.insert(paidDto);
		log.debug("ㅡㅡㅡ 결제 이력에 결제 관련내용 추가: {}", paidDto);

		// 2. 결제 내역을 포인트상품 변동이력에 저장
		PointHistoryDto pointHistoryDto = new PointHistoryDto();
		pointHistoryDto.setMemberIdx(vo.getMemberIdx());
		pointHistoryDto.setPaidIdx(vo.getPaidIdx());
		pointHistoryDto.setPointIdx(vo.getPointIdx());
		pointHistoryDto.setPointHistoryAmount(vo.getAmount());
		pointHistoryDto.setPointHistoryMemo("포인트 결제: " + vo.getName());
		log.debug("ㅡㅡㅡ 포인트상품 변동이력에 결제 관련내용 추가: {}", pointHistoryDto);
		pointHistoryDao.insert(pointHistoryDto);

		paidDao.record(payRecordVO);
		return true;

	}*/


	// 카카오페이측에 결제정보 조회를 요청하여, 저장된 결제 이력을 리턴하는 메소드
	@Override
	public KakaoPayVO detail(String tid) throws RestClientException, URISyntaxException {
		return sendPost(
			new LinkedMultiValueMap<String, String>() {{
				add("tid", tid); // 결제 일련번호
			}}, "order", KakaoPayVO.class
		);
	}

	// 카카오페이측에 결제 취소를 요청한 뒤, 그 결과를 리턴하는 메소드
	@Override
	public KakaoPayCancelResponseVO cancel(String tid, int amount) throws RestClientException, URISyntaxException {
		return sendPost(
			new LinkedMultiValueMap<String, String>() {{
				add("tid", tid); // 결제 일련번호
				add("cancel_amount", String.valueOf(amount));
				add("cancel_tax_free_amount", "0");
			}}, "cancel", KakaoPayCancelResponseVO.class
		);
	}

}
