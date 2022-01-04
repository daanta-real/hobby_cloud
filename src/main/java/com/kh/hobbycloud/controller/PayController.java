package com.kh.hobbycloud.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;

import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.service.pay.PayService;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pay")
public class PayController {

	@Autowired PayService payService;
	@Autowired PaidDao paidDao;


	// ************************************************************
	// 결제 시작
	// ************************************************************

	// 새 결제를 만드는 페이지.
	// 결제 폼이 출력되며, 여기에서 입력한 내용을 confirm으로 넘긴다.
	@GetMapping("/new")
	public String newPayForm() {
		log.debug("================== /pay/new(GET) 결제 작성 진입.");
		return "pay/new";
	}

	// 결제 내용을 최종 확인하는 페이지.
	// 사용자에게 결제 내역 페이지가 출력된다.
	@PostMapping("/confirm")
	public String confirmForm(
			@RequestParam String item_name,
			@RequestParam int quantity,
			@RequestParam int total_amount,
			Model model
		) {
		log.debug("================== /pay/confirm(POST) 결제 요청 진입.");
		log.debug("ㅡㅡㅡ입력내용: item_name={}, quantity={}, total_amount={}", item_name, quantity, total_amount);
		model.addAttribute("item_name", item_name);
		model.addAttribute("quantity", quantity);
		model.addAttribute("total_amount", total_amount);
		return "pay/confirm";
	}


	// ************************************************************
	// READY: 결제 준비 요청 단계
	// ************************************************************

	// 우리서버는 partner_order_id, partner_user_id를 생성하고,
	// 카카오페이측에 [READY]를 요청 후 tid를 받아온다. 이 세 개는 세션에 저장하며
	// 이후 사용자에게 카카오페이측의 QR코드 페이지로 안내해준다.
	@PostMapping("/ready")
	public String confirm(@ModelAttribute KakaoPayReadyRequestVO requestVO, HttpServletRequest request, HttpSession session) throws URISyntaxException {
		log.debug("================== /pay/confirm(POST) 진입. requestVO = {]", requestVO);

		// 1. VO에 각종 요구변수값 담기
		// ※ 여기서 담지는 않지만 입력 필요한 변수들: item_name, quantity, total_amount
		Integer paySequence = paidDao.getSequence();
		requestVO.setPartner_order_id(String.valueOf(paySequence)); // 결제이력 시퀀스
		requestVO.setPartner_user_id(String.valueOf(session.getAttribute("memberIdx"))); // 구매자 IDX (id 아님)
		log.debug("ㅡㅡㅡ결제 준비 요청하겠습니다: {}", requestVO);

		// 2. 카카오페이 [READY] 페이지에 결제 준비 요청한 뒤, 그 결과를 responseVO에 수신
		KakaoPayReadyResponseVO responseVO = payService.ready(requestVO, request);
		log.debug("ㅡㅡㅡ결제 준비 요청 끝. 결과 수신: {}", responseVO);

		// 3. 결제요청 성공 시, 세션에도 관련 변수를 넣음 (※ partner_user_id는 회원 ID이므로 별도 저장 불요)
		session.setAttribute("partner_order_id", paySequence);
		session.setAttribute("tid", responseVO.getTid());

		// 4. QR 페이지로 안내
		String destination = responseVO.getNext_redirect_pc_url();
		log.debug("ㅡㅡㅡ인증(QR) 페이지로 안내 목적지: redirect:{}", destination);
		return "redirect:" + destination;

	}


	// ************************************************************
	// APPROVE: 결제 최종승인 요청 단계
	// ************************************************************

	// 사용자가 confirm(GET)에서 QR코드를 찍으면, 카카오페이에 의해 여기로 넘어오게 된다.
	// 카카오페이로부터 GET방식으로 pg_token(결제 승인번호) 변수값이 넘어온다.
	// 이때 우리서버는 카카오페이측에 [APPROVE]를 요청, 금액을 실제 지불처리하게 된다.
	// 다 끝나면, DB측에 결제내용을 저장한 후 세션 같은 것들을 싹 비운 뒤 결제 결과 페이지로 안내.
	@GetMapping("/success")
	public String success(@RequestParam String pg_token, HttpSession session) throws RestClientException, URISyntaxException {
		log.debug("================== /pay/pay_success(REQUEST) 진입");

		// 세션으로부터 값 꺼냄
		String partner_order_id = String.valueOf(session.getAttribute("partner_order_id"));
		String tid = (String) session.getAttribute("tid");
		// List<ProductDto> list = (List<ProductDto>) session.getAttribute("list"); // 상품 정보

		// 볼일 끝났으면 세션 삭제
		session.removeAttribute("partner_order_id");
		session.removeAttribute("tid");
		// session.removeAttribute("list");

		// 카카오페이에게 승인 [APPROVE] 요청
		KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
		requestVO.setPartner_order_id(partner_order_id);
		requestVO.setPartner_user_id(String.valueOf(session.getAttribute("memberIdx")));
		requestVO.setTid(tid);
		requestVO.setPg_token(pg_token);
		log.debug("ㅡㅡㅡ결제 최종승인 요청: {}", requestVO);
		KakaoPayApproveResponseVO responseVO = payService.approve(requestVO);
		log.debug("ㅡㅡㅡ결제 최종승인 요청 결과: {}", responseVO);

		// 성공한 결제기록에 대해 INSERT 수행(생략)

		// 성공결과 확인 페이지로 이동
		return "redirect:success_result";

	}

	// 카카오페이 승인 완료 페이지
	@GetMapping("/success_result")
	public String successResult() {
		return "pay/success_result";
	}

	// 카카오페이 실패 페이지
	@ResponseBody
	@RequestMapping("/fail")
	public String fail() {
		log.debug("================== /pay/fail(GET) 진입");

		// 실패한 결제기록에 대해 INSERT 수행(생략)

		// 실패 페이지로 리다이렉트
		return "pay/fail";
	}

	// ************************************************************
	// 이력 조회
	// ************************************************************

	// 목록
	@GetMapping("/list")
	public String list() {
		log.debug("================== /pay/list(GET) 진입");
		return "pay/list";
	}

	// 상세
	@GetMapping("/detail/{idx}")
	public String detail(@PathVariable int idx, Model model) throws RestClientException, URISyntaxException {
		log.debug("================== /pay/detail/{idx} (GET) 진입");

		PaidVO paidVO = paidDao.getByIdx(idx);
		KakaoPayVO kakaoPayVO = payService.detail(paidVO.getPaidTid());
		model.addAttribute("paidVO", paidVO);
		model.addAttribute("paidVO", kakaoPayVO);

		return "pay/detail";

	}

	// ************************************************************
	// 취소
	// ************************************************************

	// 취소 요청
	@GetMapping("/cancel/{paidIdx}")
	public String cancel(@PathVariable int paidIdx, Model model) throws Exception {
		log.debug("================== /pay/cancel/{paidIdx} (GET) 진입");

		// idx로 tid 및 amount 알아내기
		PaidVO vo = paidDao.getByIdx(paidIdx);
		String tid = vo.getPaidTid();
		Integer paidPrice = vo.getPaidPrice();
		log.debug("ㅡㅡ대상 결제이력: {}", vo);
		log.debug("ㅡㅡtid: {}", tid);
		log.debug("ㅡㅡpaidPrice: {}", paidPrice);

		// 해당 결제가 이미 취소되어 있으면 빠꾸
		if(!vo.getPaidStatus()) {
			log.debug("ㅡㅡ결제를 취소할 수 없습니다. 이미 취소된 결제입니다.");
			throw new Exception();
		}

		// 결제 취소 진행
		KakaoPayCancelResponseVO responseVO = payService.cancel(tid, paidPrice);
		log.debug("ㅡㅡ취소 결과: {}", responseVO);
		model.addAttribute("cancelResponseVO", responseVO);

		// 결제 취소 컨트롤러로
		return "/pay/cancel_result";
	}

}
