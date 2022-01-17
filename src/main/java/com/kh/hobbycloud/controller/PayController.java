package com.kh.hobbycloud.controller;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestClientException;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.entity.point.PointDto;
import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.repository.point.PointDao;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.service.pay.PayService;
import com.kh.hobbycloud.util.CommonUtils;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayApproveResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayCancelResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyRequestVO;
import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;
import com.kh.hobbycloud.vo.pay.KakaoPayVO;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my/pay")
public class PayController {

	@Autowired PayService payService;
	@Autowired PaidDao paidDao;
	@Autowired PointDao pointDao;
	@Autowired PointHistoryDao pointHistoryDao;
	@Autowired MemberDao memberDao;

	// PayController에서 사용하는 모든 세션 정보를 출력하는 메소드
	public void printAllSessionStatus(HttpSession session) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ PayController에서 현 시점 사용하는 세션 정보 출력");
		log.debug("세션 저장 정보 - paidIdx: {}"    , session.getAttribute("paidIdx"    ));;
		log.debug("세션 저장 정보 - memberIdx: {}"  , session.getAttribute("memberIdx"  ));
		log.debug("세션 저장 정보 - paidName: {}"   , session.getAttribute("paidName"   ));
		log.debug("세션 저장 정보 - paidPrice: {}"  , session.getAttribute("paidPrice"  ));
		log.debug("세션 저장 정보 - paidTid: {}"    , session.getAttribute("paidTid"    ));
		log.debug("세션 저장 정보 - pointIdx: {}"   , session.getAttribute("pointIdx"   ));
		log.debug("세션 저장 정보 - pointAmount: {}", session.getAttribute("pointAmount"));
	}

	// PayController에서 사용하는 모든 세션 정보를 삭제하는 메소드
	public void truncateAllSessions(HttpSession session) {
		session.removeAttribute("paidIdx"     );
		session.removeAttribute("paidName"    );
		session.removeAttribute("paidPrice"   );
		session.removeAttribute("paidTid"     );
		session.removeAttribute("pointIdx"    );
		session.removeAttribute("pointAmount" );
	}

	// ************************************************************
	// 결제 시작
	// ************************************************************

	// 새 결제를 만드는 페이지.
	// 모든 포인트상품의 목록이 출력된다.
	// 결제 폼이 출력되며, 여기에서 입력한 내용을 confirm으로 넘긴다.
	@RequestMapping("/new")
	public String newPayForm(Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/new(GET) 결제 신규작성(테스트) 진입.");
		List<PointDto> list = pointDao.select();
		model.addAttribute("pointList", list);
		return "my/pay/new";
	}

	// 결제 내용을 최종 확인하는 페이지.
	// 사용자에게 결제 내역 페이지가 출력된다.
	@GetMapping("/buyConfirm")
	public String buyConfirm(
				@RequestParam int pointIdx,
				HttpSession session,
				Model model
			) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/buyConfirm(GET) 결제 요청 진입. pointIdx={}", pointIdx);
		printAllSessionStatus(session);
		PointDto pointDto = pointDao.getByIdx(pointIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 대상 포인트상품 정보 조회(pointIdx {}짜리): {}", pointIdx, pointDto);
		model.addAttribute("pointName", pointDto.getPointName());
		model.addAttribute("pointPrice", pointDto.getPointPrice());
		model.addAttribute("pointAmount", pointDto.getPointAmount());
		session.setAttribute("pointIdx", pointIdx); // 결제할 포인트상품 번호를 이 단계에서 미리 저장함
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ pointIdx를 세션에 저장했습니다. 저장된 세션 정보: {}",
			session.getAttribute("pointIdx"));
		printAllSessionStatus(session);
		return "my/pay/confirm_pay";
	}


	// ************************************************************
	// READY: 결제 준비 요청 단계
	// ************************************************************

	// 여기에는 item_name, item_quantity, total_amount 세 개가 들어온다.
	// 우리서버는 partner_order_id, partner_user_id를 생성하고,
	// 카카오페이측에 [READY]를 요청 후 tid를 받아온다. 이 세 개는 세션에 저장하며
	// 이후 사용자에게 카카오페이측의 QR코드 페이지로 안내해준다.
	@RequestMapping("/ready")
	public String confirm(
				HttpServletRequest request,
				HttpSession session) throws URISyntaxException {

		int pointIdx = (int) session.getAttribute("pointIdx"); // 결제할 포인트상품 번호
		PointDto pointDto = pointDao.getByIdx(pointIdx); // 결제할 포인트상품 상세 정보
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/ready(GET) 진입. 결제할 포인트상품 정보:{}", pointDto);
		printAllSessionStatus(session);
		String pointName = pointDto.getPointName();
		int pointPrice = pointDto.getPointPrice();
		int pointAmount = pointDto.getPointAmount();

		// 1. 우리측 결제이력 일련번호의 paid_idx 역할이자,
		// 카카오페이측에 partner_order_id로 제출할 새 시퀀스를 뽑는다.
		Integer paidSequence = paidDao.getSequence();

		// 2. 입력값을 이용해, 내가 결제 요청하고자 하는 정보 객체인 requestVO를 만든다.
		KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
		requestVO.setPartner_order_id(String.valueOf(paidSequence)); // 우리측 결제이력 일련번호
		requestVO.setPartner_user_id(String.valueOf(session.getAttribute("memberIdx"))); // 구매자 IDX (id 아님)
		requestVO.setItem_name(pointName);
		requestVO.setTotal_amount(pointPrice);
		requestVO.setQuantity(1); // 상품 결제 수량. 어차피 반드시 1개의 상품만 결제할 것이므로 1로 고정이다.
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 준비 요청하겠습니다: {}", requestVO);

		// 3. 카카오페이 [READY] 페이지에 결제 준비 요청을 보낸다.
		// 그리고 카카오페이로부터 돌아온 결과를 responseVO에 수신
		KakaoPayReadyResponseVO responseVO = payService.ready(requestVO, request);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 준비 요청 끝. 결과 수신: {}", responseVO);

		// 4. 결제요청 완료 시, 세션에 관련 변수를 저장
		session.setAttribute("paidIdx", paidSequence);
		session.setAttribute("paidName", pointName);
		session.setAttribute("paidPrice", pointPrice);
		session.setAttribute("paidTid", responseVO.getTid());
		session.setAttribute("pointAmount", pointAmount);

		// 56. 사용자측을 QR 페이지로 안내함
		String destination = responseVO.getNext_redirect_pc_url();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 인증(QR) 페이지로 안내 목적지: redirect:{}", destination);
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

		// 페이지 정보 및 세션 현황 출력
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/success(GET) 진입. 입력값: {}", pg_token);
		printAllSessionStatus(session);

		// 세션으로부터 값 다 꺼냄
		int    paidIdx     = (int)          session.getAttribute("paidIdx"    );
		int    memberIdx   = (int)          session.getAttribute("memberIdx"  );
		String paidName    = String.valueOf(session.getAttribute("paidName"   ));
		int    paidPrice   = (int)          session.getAttribute("paidPrice"  );
		String paidTid     = String.valueOf(session.getAttribute("paidTid"    ));
		int    pointIdx    = (int)          session.getAttribute("pointIdx"   ); // 결제할 포인트상품 번호
		int    pointAmount = (int)          session.getAttribute("pointAmount"); // 포인트 충전량

		// 카카오페이에게 승인 [APPROVE] 요청 보내고 그 결과를 회신받음.
		KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
		requestVO.setPartner_order_id(String.valueOf(paidIdx));
		requestVO.setPartner_user_id(String.valueOf(memberIdx));
		requestVO.setTid(paidTid);
		// ★ !!!! 이 부분이 중요. QR 찍고 받아온 최종 승인 번호인 pg_token을 넘겨야 결제가 최종 실행된다.
		requestVO.setPg_token(pg_token);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 실행(approve) 요청: {}", requestVO);
		KakaoPayApproveResponseVO responseVO = payService.approve(requestVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 실행(approve) 요청 완료 (=결제 최종 실행 완료.) 결과: {}", responseVO);

		// 결제가 최종 완료된 이후, 각종 테이블에 결제내역을 저장/반영할 서비스를 실행시킨다.
		// 1. PAID 테이블
		PaidDto paidDto = new PaidDto();
		paidDto.setPaidIdx(paidIdx);
		paidDto.setMemberIdx(memberIdx);
		paidDto.setPaidTid(paidTid);
		paidDto.setPaidName(paidName); // 결제한 상품명 (for paid.name)
		paidDto.setPaidPrice(paidPrice); // 결제 금액
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 이력 기록(paidDao.insert): {}", paidDto);
		paidDao.insert(paidDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 이력 기록(paidDao.insert) 완료.");

		// 2. point_history 테이블
		PointHistoryDto pointHistoryDto = new PointHistoryDto();
		pointHistoryDto.setMemberIdx(memberIdx);
		pointHistoryDto.setPaidIdx(paidIdx);
		pointHistoryDto.setPointIdx(pointIdx);
		pointHistoryDto.setPointHistoryAmount(pointAmount);
		pointHistoryDto.setPointHistoryMemo("포인트 결제: " + paidName);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 포인트 변동이력 기록(pointHistoryDao.insert): {}", pointHistoryDto);
		pointHistoryDao.insert(pointHistoryDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 포인트 변동이력 기록(pointHistoryDao.insert) 완료.");

		// 3. member 테이블
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(memberIdx);
		memberDto.setMemberPoint(pointAmount);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 포인트 보유량 변경(MemberDao.pointModify): {}", memberDto);
		memberDao.pointModify(memberDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 포인트 보유량 변경(MemberDao.pointModify) 완료.");

		// 결제 관련 프로세스가 모두 끝났으니, 모든 관련세션 삭제
		truncateAllSessions(session);

		// 성공 확인 페이지로 이동
		return "redirect:success_pay";

	}

	@GetMapping("/success_pay")
	public String success() {
		// 성공 확인 페이지로 이동
		return "my/pay/success_pay";
	}

	// 카카오페이 실패 페이지
	@RequestMapping("/fail")
	public String fail(HttpSession session) {
		// 페이지 정보 및 세션 현황 출력
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/fail(GET) 진입.");
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 변경전 세션 내역");
		printAllSessionStatus(session);

		// 모든 관련세션 삭제
		truncateAllSessions(session);

		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 변경후");
		printAllSessionStatus(session);

		// 실패 페이지로 리다이렉트
		return "my/pay/fail";
	}

	// ************************************************************
	// 이력 조회
	// ************************************************************

	// 목록 (운영자용)
	@RequestMapping("/")
	public String list(PaidSearchVO paidSearchVO, HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/list(GET) 진입");
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		boolean isLoggedIn = memberIdx != null;
		boolean isAdmin
			=  isLoggedIn
			&& session.getAttribute("memberGrade") != null
			&& session.getAttribute("memberGrade").equals("관리자");
		if(!isAdmin) paidSearchVO.setMemberIdx(String.valueOf(session.getAttribute("memberIdx")));
		List<PaidVO> paidList = paidDao.select(paidSearchVO);
		model.addAttribute("paidList", paidList);
		return "my/pay/list";
	}

	// 상세
	@GetMapping("/detail/{idx}")
	public String detail(@PathVariable int idx, Model model) throws RestClientException, URISyntaxException {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/detail/{idx} (GET) 진입");

		PaidVO paidVO = paidDao.getByIdx(idx);
		paidVO.prepareDateStr();
		KakaoPayVO kakaoPayVO = payService.detail(paidVO.getPaidTid());
		model.addAttribute("paidVO", paidVO);
		model.addAttribute("kakaoPayVO", kakaoPayVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 찾아낸 PaidVO: {}", paidVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 찾아낸 kakaoPayVO: {}", kakaoPayVO);
		model.addAttribute("paidPrice", CommonUtils.attachComma(paidVO.getPaidPrice()));

		return "my/pay/detail";

	}

	// ************************************************************
	// 취소 기능
	// ************************************************************

	// 취소 요청
	@GetMapping("/cancel/{paidIdx}")
	public String cancel(@PathVariable int paidIdx, Model model) throws Exception {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /pay/cancel/{paidIdx} (GET) 진입");

		// idx로 tid 및 amount 알아내기
		PaidVO vo = paidDao.getByIdx(paidIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 대상 결제이력: {}", vo);
		String paidTid = vo.getPaidTid();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ paidTid: {}", paidTid);
		Integer paidPrice = vo.getPaidPrice();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ paidPrice: {}", paidPrice);
		log.debug("vo.getPaidIdx() = {}", vo.getPaidIdx());
		log.debug("pointHistoryDao.getByPaidIdx(vo.getPaidIdx()) = {}", pointHistoryDao.getByPaidIdx(vo.getPaidIdx()));
		PointHistoryDto historyDto = pointHistoryDao.getByPaidIdx(vo.getPaidIdx());
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ pointHistoryDto: {}", historyDto);

		// 해당 결제가 이미 취소되어 있으면 빠꾸
		if(!vo.getPaidStatus()) {
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제를 취소할 수 없습니다. 이미 취소된 결제입니다.");
			throw new Exception();
		}

		// 취소 후 잔액이 마이너스가 될 것 같으면 빠꾸
		MemberDto memberDto = memberDao.getByIdx(vo.getMemberIdx());
		int curr = memberDto.getMemberPoint();
		int minus = historyDto.getPointHistoryAmount();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 현재 포인트 보유량: {}", curr);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 차감할 포인트 보유량: {}", minus);
		boolean pointAfterCancel = curr > minus;
		if(!pointAfterCancel) {
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제를 취소할 수 없습니다. 잔고가 모자랍니다.");
			throw new Exception();
		}

		// 결제 취소 진행
		KakaoPayCancelResponseVO responseVO = payService.cancel(paidTid, paidPrice);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 취소 결과: {}", responseVO);
		model.addAttribute("cancelResponseVO", responseVO);

		// 결제 취소 결과를 반영: point history

		// 결제가 최종 완료된 이후, 각종 테이블에 결제내역을 저장/반영할 서비스를 실행시킨다.
		// 1. PAID 테이블
		PaidDto paidDto = new PaidDto();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 이력 기록(paidDao.markCancel): {}", paidDto);
		paidDao.cancel(paidIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 결제 이력 기록(paidDao.markCancel) 완료.");

		// 2. point_history 테이블
		PointHistoryDto pointHistoryDto = new PointHistoryDto();
		pointHistoryDto.setMemberIdx(vo.getMemberIdx());
		pointHistoryDto.setPaidIdx(paidIdx);
		pointHistoryDto.setPointIdx(historyDto.getPointIdx());
		pointHistoryDto.setPointHistoryAmount(-historyDto.getPointHistoryAmount());
		pointHistoryDto.setPointHistoryMemo("포인트 결제 취소: " + historyDto.getPointHistoryMemo());
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 포인트 변동이력 기록(pointHistoryDao.insert): {}", pointHistoryDto);
		pointHistoryDao.insert(pointHistoryDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 포인트 변동이력 기록(pointHistoryDao.insert) 완료.");

		// 3. member 테이블
		MemberDto memberDtoRecord = new MemberDto();
		memberDtoRecord.setMemberIdx(vo.getMemberIdx());
		memberDtoRecord.setMemberPoint(-historyDto.getPointHistoryAmount());
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 포인트 보유량 변경(MemberDao.pointModify): {}", memberDto);
		memberDao.pointModify(memberDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 포인트 보유량 변경(MemberDao.pointModify) 완료.");

		// 결제 취소 컨트롤러로
		return "my/pay/success_cancel";

	}

}
