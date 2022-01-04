package com.kh.hobbycloud.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.service.pay.PayService;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pay")
public class PayController {

	@Autowired PayService payService;
	@Autowired PaidDao paidDao;

	// 새 결제를 만드는 페이지.
	// 결제 폼이 출력되며, 여기에서 입력한 내용을 confirm으로 넘긴다.
	@GetMapping("/new")
	public String newPayForm() {
		log.debug("================== /pay/new(GET) 결제 작성 진입.");
		return "pay/new";
	}

	// 결제 내용을 최종 확인하는 페이지.
	// 사용자에게 결제 내역 페이지가 출력된다.
	// 사용자가 확인 버튼을 누르면, /pay/confirm (POST)로 넘어간다.
	@GetMapping("/confirm")
	public String confirm() {
		log.debug("================== /pay/confirm(GET) 결제 요청 진입.");
		return "pay/confirm";
	}

	// 우리서버는 partner_order_id, partner_user_id를 생성하고,
	// 카카오페이측에 [READY]를 요청 후 tid를 받아온다. 이 세 개는 세션에 저장하며
	// 이후 사용자에게 카카오페이측의 QR코드 페이지로 안내해준다.
	@PostMapping("/confirm")
	public String confirm(HttpSession session, @ModelAttribute KakaoPayReadyRequestVO requestVO) throws URISyntaxException {
		log.debug("================== /pay/confirm(POST) 진입. requestVo = {]", requestVO);

		// 1. DB 시퀀스 생성
		Integer paySequence = paidDao.getSequence();

		// 2. 카카오페이 [READY] 페이지에 결제 준비 요청한 뒤, 그 결과를 responseVO에 수신
		KakaoPayReadyResponseVO responseVO = payService.ready(requestVO);

		// 3. 세션에도 관련 변수를 넣음 (※ partner_user_id는 회원 ID이므로 별도 저장 불요)
		session.setAttribute("partner_order_id", paySequence);
		session.setAttribute("tid", responseVO.getTid());
		return "redirect:";

	}

	// 사용자가 confirm(GET)에서 QR코드를 찍으면, 카카오페이에 의해 여기로 넘어오게 된다.
	// 카카오페이로부터 GET방식으로 pg_token(결제 승인번호) 변수값이 넘어온다.
	// 이때 우리서버는 카카오페이측에 [APPROVE]를 요청, 금액을 실제 지불처리하게 된다.
	// 다 끝나면, DB측에 결제내용을 저장한 후 세션 같은 것들을 싹 비운 뒤 결제 결과 페이지로 안내.
	@RequestMapping("/pay_success")
	public String success() {
		log.debug("================== /pay/pay_success(REQUEST) 진입");
		return "redirect:success"; // success.jsp가 결제 성공 및 결과안내 페이지이다.
	}

	// 카카오페이 실패 페이지
	@ResponseBody
	@RequestMapping("/fail")
	public String fail() {
		log.debug("================== /pay/fail(GET) 진입");
		// 실패한 결과를 DB에 넣음

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
	public String detail(@PathVariable int idx, Model model) {
		log.debug("================== /pay/detail/{idx} (GET) 진입");
		// 1. 값 준비
		// idx 검사
		// 2. DB에 결제이력 조회
		// 3. 카카오페이에 값 조회 요청 (detail)
		// 4. 조회된 값 DTO에 넣기
		//model.setAttribute("payHistoryDto", paidDao.detail(idx));
		// 5. 페이지로 리다이렉트
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
		PaidDto dto = paidDao.getByIdx(paidIdx);
		String tid = dto.getPaidTid();
		Integer paidPrice = dto.getPaidPrice();
		log.debug("ㅡㅡ대상 결제이력: {}", dto);
		log.debug("ㅡㅡtid: {}", tid);
		log.debug("ㅡㅡpaidPrice: {}", paidPrice);

		// 해당 결제가 이미 취소되어 있으면 빠꾸
		if(dto.getPaidStatus().equals('0')) {
			log.debug("ㅡㅡ결제를 취소할 수 없습니다. 이미 취소된 결제입니다.");
			throw new Exception();
		}

		// 결제 취소 진행
		KakaoPayCancelResponseVO responseVO = payService.cancel(tid, paidPrice);
		log.debug("ㅡㅡ취소 결과: {}", responseVO);
		model.addAttribute("cancelResponseVO", responseVO);

		// 결제 취소 컨트롤러로
		return "/pay/cancel_success";
	}

}
