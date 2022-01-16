package com.kh.hobbycloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.pay.LecMyDto;
import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.pay.LecMyDao;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecMyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecMy")
public class LecMyController {

	@Autowired LecDao lecDao;
	@Autowired PointHistoryDao pointHistoryDao;
	@Autowired MemberDao memberDao;
	@Autowired LecMyDao lecMyDao;

	// 강좌 구매를 선택했을 때, 구매 의사를 확인하는 페이지
	@GetMapping("/confirm/{lecIdx}")
	public String confirm(@PathVariable int lecIdx, HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /myLec/confirm/{} (GET) 강좌 구매 확인 페이지 진입", lecIdx);

		if(session.getAttribute("memberIdx") == null) {//로그인 하지 않았으면
			return "redirect:/member/login";//로그인 화면으로 리다이렉트
		}

		// 회원 현재 보유 포인트를 뷰로 넘김
		MemberDto memberDto = memberDao.getByIdx((int) session.getAttribute("memberIdx"));

		int currentPoint = memberDto.getMemberPoint();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 포인트 정보를 조회합니다. 조회 결과: {}", currentPoint);
		model.addAttribute("currentPoint", currentPoint);

		// 구매 대상 강좌 정보를 뷰로 넘김
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		model.addAttribute("lecDetailVO", lecDetailVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 강좌 정보를 조회합니다. 조회 결과: {}", lecDetailVO);

		// lecIdx를 세션에 저장 (세션에 저장하는 게 좋을 것 같음 - 정보 변조 방지)
		session.setAttribute("buyTargetLecIdx", lecIdx);

		return "lecMy/confirm_buy";
	}

	// 강좌 구매 실행 페이지
	@GetMapping("/execute_buy")
	public String buy_execute(HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /lecMy/buy (GET) 강좌 구매를 실행합니다.");

		// 변수 없으면 에러

		// 변수 정의
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		Integer lecIdx = (Integer) session.getAttribute("buyTargetLecIdx");
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원번호: {} / 대상 강좌idx: {}", lecIdx, memberIdx);
		if(memberIdx == null || lecIdx == null) {
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 번호나 대상 강좌idx가 비었습니다. 에러페이지로 갑니다.");
			return "error/500";
		}

		// 구매 대상 강좌 정보 조회
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		String lecName = lecDetailVO.getLecName();
		int pointAmount = lecDetailVO.getLecPrice();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 대상 강좌명: {} / 포인트 소모량: {}", lecName, lecDetailVO.getLecPrice());
		model.addAttribute("lecDto", lecDetailVO);

		// 1. 포인트 변동이력 기록 (point_history)
		PointHistoryDto pointHistoryDto = new PointHistoryDto();
		int pointHistoryIdx = pointHistoryDao.getSequence();
		pointHistoryDto.setPointHistoryIdx(pointHistoryIdx);
		pointHistoryDto.setMemberIdx(memberIdx);
		pointHistoryDto.setPointHistoryAmount(pointAmount);
		pointHistoryDto.setPointHistoryMemo("강좌 구매: " + lecName);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 강좌 구매로 포인트가 감소된 이력을 기록하겠습니다. pointHistoryDto = {}", pointHistoryDto);
		pointHistoryDao.insert(pointHistoryDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 강좌 구매로 포인트가 감소된 이력을 기록하였습니다.");

		// 2. 멤버 포인트 감소 처리 (member)
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(memberIdx);
		memberDto.setMemberPoint(-pointAmount);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 강좌를 구매함으로 인해 회원 포인트가 {} 감소하는 처리를 하겠습니다. (-{}점) / memberDto = {}", pointAmount, memberDto);
		memberDao.pointModify(memberDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 강좌를 구매함으로 인해 회원 포인트가 {} 감소되었습니다.", pointAmount);

		// 3. 내 강좌 보관소에 강좌정보 등록 (lec_my)
		LecMyDto myLecDto = new LecMyDto();
		myLecDto.setLecIdx(lecIdx);
		myLecDto.setMemberIdx(memberIdx);
		myLecDto.setPointHistoryIdx(pointHistoryIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 내 강좌 보관소에 강좌정보를 등록하겠습니다. myLecDto = {}", myLecDto);
		lecMyDao.insert(myLecDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 내 강좌 보관소에 강좌정보를 등록하였습니다.");

		// 세션 비우기
		session.removeAttribute("buyTargetLecIdx");

		return "lecMy/success_buy";
	}

	//내 강좌 보기
	@GetMapping("/myLec")
	public String myLec(HttpSession session, Model model) {
		if(session.getAttribute("memberIdx") == null) {//로그인 하지 않았으면
			return "redirect:/member/login";//로그인 화면으로 리다이렉트
		}

		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		List<LecMyVO> myLecList = lecMyDao.getMyLec(memberIdx);
		model.addAttribute("myLecList", myLecList);
		return "lecMy/my_lec";
	}

}
