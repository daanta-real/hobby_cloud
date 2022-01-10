package com.kh.hobbycloud.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.service.pay.PayService;
import com.kh.hobbycloud.util.CommonUtils;
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
			@RequestParam int total_amount,
			Model model
		) {
		log.debug("================== /pay/confirm(POST) 결제 요청 진입.");
		log.debug("ㅡㅡㅡ입력내용: item_name={}, total_amount={}", item_name, total_amount);
		model.addAttribute("item_name", item_name);
		model.addAttribute("total_amount", total_amount);
		return "pay/confirm";
	}


	// ************************************************************
	// READY: 결제 준비 요청 단계
	// ************************************************************

	// 여기에는 item_name, item_quantity, total_amount 세 개가 들어온다.
	// 우리서버는 partner_order_id, partner_user_id를 생성하고,
	// 카카오페이측에 [READY]를 요청 후 tid를 받아온다. 이 세 개는 세션에 저장하며
	// 이후 사용자에게 카카오페이측의 QR코드 페이지로 안내해준다.
	@PostMapping("/ready")
	public String confirm(
				@RequestParam String item_name,
				@RequestParam int total_amount,
				HttpServletRequest request,
				HttpSession session) throws URISyntaxException {

		log.debug("================== /pay/ready(POST) 진입. 상품명:{] / 결제제금액: {}", item_name, total_amount);

		// 1. 우리측 결제이력 일련번호의 paid_idx 역할이자,
		// 카카오페이측에 partner_order_id로 제출할 새 시퀀스를 뽑는다.
		Integer paidSequence = paidDao.getSequence();

		// 2. 입력값을 이용해, 내가 결제 요청하고자 하는 정보 객체인 requestVO를 만든다.
		KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
		requestVO.setPartner_order_id(String.valueOf(paidSequence)); // 우리측 결제이력 일련번호
		requestVO.setPartner_user_id(String.valueOf(session.getAttribute("memberIdx"))); // 구매자 IDX (id 아님)
		requestVO.setItem_name(item_name);
		requestVO.setTotal_amount(total_amount);
		requestVO.setQuantity(1); // 상품 결제 수량. 어차피 반드시 1개의 상품만 결제할 것이므로 1로 고정이다.
		log.debug("ㅡㅡㅡ결제 준비 요청하겠습니다: {}", requestVO);

		// 3. 카카오페이 [READY] 페이지에 결제 준비 요청을 보낸다.
		// 그리고 카카오페이로부터 돌아온 결과를 responseVO에 수신
		KakaoPayReadyResponseVO responseVO = payService.ready(requestVO, request);
		log.debug("ㅡㅡㅡ결제 준비 요청 끝. 결과 수신: {}", responseVO);

		// 4. 결제요청 완료 시, 세션에 관련 변수를 저장
		session.setAttribute("paidIdx", paidSequence);
		session.setAttribute("paidName", item_name);
		session.setAttribute("paidPrice", total_amount);
		session.setAttribute("paidTid", responseVO.getTid());

		// 56. 사용자측을 QR 페이지로 안내함
		String destination = responseVO.getNext_redirect_pc_url();
		log.debug("ㅡㅡㅡ인증(QR) 페이지로 안내 목적지: redirect:{}", destination);
		return "redirect:" + destination;

	}


	// ************************************************************
	// APPROVE: 결제 최종승인 요청 단계
	// ************************************************************

	// 사용자가 confirm(GET)에서 QR코드를 찍는 것이 성공(success)하면, 카카오페이의 결제 준비가 완전히 끝난다.
	// 하지만 카카오페이에서는 여기서 바로 돈을 결제하지 않고,
	// 준비된 결제 내용을 서버 측에 한 번 더 확인하는 절차를 요구한다.
	// 그러니까, 서버 측에서는 준비된 결제 내용을 한 번 더 확인하여 카카오페이지에 실행(approve)을 따로 요청을 해야 된다.
	//
	// 아무튼, 카카오페이로부터 GET방식으로 pg_token(결제 승인번호) 변수값이 넘어온다.
	// 이후 우리서버는 이 pg_token을 VO에 담아 카카오페이측에 (approve)를 요청하여
	// 금액을 실제 지불처리하게 된다.
	//
	// 거기까지 끝나면, DB측에 결제내용을 저장한 후 세션 같은 것들을 싹 비운 뒤 결제 결과 페이지로 안내.
	@GetMapping("/success")
	public String success(@RequestParam String pg_token, HttpSession session) throws RestClientException, URISyntaxException {
		log.debug("================== /pay/success(GET) 진입. 입력값: {}", pg_token);

		// 세션으로부터 값 다 꺼냄
		int    paidIdx   = (int)          session.getAttribute("paidIdx"  );
		int    memberIdx = (int)          session.getAttribute("memberIdx");
		String paidName  = String.valueOf(session.getAttribute("paidName"));
		int    paidPrice = (int)          session.getAttribute("paidPrice");
		String paidTid   = String.valueOf(session.getAttribute("paidTid" ));
		log.debug("ㅡㅡㅡ세션으로부터 값 다 꺼내기: paidIdx({}), memberIdx({}), paidName({}), paidPrice({}), paidTid({})", paidIdx, memberIdx, paidName, paidPrice, paidTid);

		// 카카오페이에게 승인 [APPROVE] 요청 보내고 그 결과를 회신받음.
		KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
		requestVO.setPartner_order_id(String.valueOf(paidIdx));
		requestVO.setPartner_user_id(String.valueOf(memberIdx));
		requestVO.setTid(paidTid);
		// ★ !!!! 이 부분이 중요. QR 찍고 받아온 최종 승인 번호인 pg_token을 넘겨야 결제가 최종 실행된다.
		requestVO.setPg_token(pg_token);
		log.debug("ㅡㅡㅡ결제 실행(approve) 요청: {}", requestVO);
		KakaoPayApproveResponseVO responseVO = payService.approve(requestVO);
		log.debug("ㅡㅡㅡ결제 실행(approve) 요청 완료 (=결제 최종 실행 완료.) 결과: {}", responseVO);

		// 결제가 최종 완료되었으면, 모든 관련세션 삭제
		session.removeAttribute("paidIdx"  );
		session.removeAttribute("paidName" );
		session.removeAttribute("paidPrice");
		session.removeAttribute("paidTid"  );

		// 이후, 결제된 이력을 DTO로 만들어 paid 테이블에 insert시킴
		PaidDto paidDto = new PaidDto();
		paidDto.setPaidIdx(paidIdx);
		paidDto.setMemberIdx(memberIdx);
		paidDto.setPaidTid(paidTid);
		paidDto.setPaidIdx(paidIdx);
		paidDto.setPaidName(paidName);
		paidDto.setPaidPrice(paidPrice);
		paidDao.insert(paidDto);

		// 성공 확인 페이지로 이동
		return "pay/success_result";

	}

	// 카카오페이 실패 페이지
	@ResponseBody
	@RequestMapping("/fail")
	public String fail(HttpSession session) {
		log.debug("================== /pay/fail(GET) 진입");

		// 세션으로부터 내가 결제하고자 하는 상품 정보 빼기
		session.removeAttribute("item_name");
		session.removeAttribute("quantity");
		session.removeAttribute("total_amount");

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
		paidVO.prepareDateStr();
		KakaoPayVO kakaoPayVO = payService.detail(paidVO.getPaidTid());
		model.addAttribute("paidVO", paidVO);
		model.addAttribute("kakaoPayVO", kakaoPayVO);
		log.debug("ㅡㅡㅡ찾아낸 PaidVO: {}", paidVO);
		log.debug("ㅡㅡㅡ찾아낸 kakaoPayVO: {}", kakaoPayVO);
		model.addAttribute("paidPrice", CommonUtils.attachComma(paidVO.getPaidPrice()));

		return "pay/detail";

	}

	// ************************************************************
	// 취소 기능
	// ************************************************************

	// 취소 요청
	@GetMapping("/cancel/{paidIdx}")
	public String cancel(@PathVariable int paidIdx, Model model) throws Exception {
		log.debug("================== /pay/cancel/{paidIdx} (GET) 진입");

		// idx로 tid 및 amount 알아내기
		PaidVO vo = paidDao.getByIdx(paidIdx);
		String paidTid = vo.getPaidTid();
		Integer paidPrice = vo.getPaidPrice();
		log.debug("ㅡㅡ대상 결제이력: {}", vo);
		log.debug("ㅡㅡpaidTid: {}", paidTid);
		log.debug("ㅡㅡpaidPrice: {}", paidPrice);

		// 해당 결제가 이미 취소되어 있으면 빠꾸
		if(!vo.getPaidStatus()) {
			log.debug("ㅡㅡ결제를 취소할 수 없습니다. 이미 취소된 결제입니다.");
			throw new Exception();
		}

		// 결제 취소 진행
		KakaoPayCancelResponseVO responseVO = payService.cancel(paidTid, paidPrice);
		log.debug("ㅡㅡ취소 결과: {}", responseVO);
		model.addAttribute("cancelResponseVO", responseVO);

		// 결제 취소 컨트롤러로
		return "/pay/cancel_result";

	}

}
