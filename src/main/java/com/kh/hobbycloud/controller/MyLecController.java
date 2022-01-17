package com.kh.hobbycloud.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.pay.MyLecDto;
import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.pay.MyLecDao;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.MyLecVO;
import com.kh.hobbycloud.vo.pay.MyLecSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my/lec")
public class MyLecController {

	@Autowired LecDao lecDao;
	@Autowired MyLecDao myLecDao;
	@Autowired PointHistoryDao pointHistoryDao;
	@Autowired MemberDao memberDao;

	//내 강좌 보기
	@RequestMapping("/")
	public String myLec(MyLecSearchVO myLecSearchVO, HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/lec 내 강좌 페이지 진입");
		List<LinkedHashMap<String, String>> listNew = new ArrayList<>();

		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		myLecSearchVO.setMemberIdx(memberIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 검색조건: {}", myLecSearchVO);
		List<MyLecVO> listOrg = myLecDao.select(myLecSearchVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ Original list 목록: {}개, {}", listOrg.size(), listOrg);
		int count = 1;
		for(MyLecVO listOne: listOrg) {
			LinkedHashMap<String, String> map = new LinkedHashMap<>();
			map.put("순", String.valueOf(count++));
			map.put("targetIdx", String.valueOf(listOne.getLecMyIdx()));
			map.put("내강좌번호", String.valueOf(listOne.getLecMyIdx()));
			map.put("강좌번호", String.valueOf(listOne.getLecIdx()));
			map.put("분류", String.valueOf(listOne.getLecContainsCount()));
			map.put("강좌명", listOne.getLecName());
			map.put("지역", listOne.getLecLocRegion());
			map.put("강좌수", String.valueOf(listOne.getLecContainsCount()));
			map.put("시작일", String.valueOf(listOne.getLecStart()));
			map.put("종료일", String.valueOf(listOne.getLecEnd()));
			map.put("강사명", listOne.getMemberNick());//강사 이름
			listNew.add(map);
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 Maps 목록: {}", map);
		}

		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 전체 Maps 목록: {}개 - {}", listNew.size(), listNew);
		model.addAttribute("list", listNew);

		String title = "내 강좌 목록";
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 페이지 제목: {}", title);
		model.addAttribute("title", title);

		String menu = "lec";
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 메뉴명: {}", menu);
		model.addAttribute("menu", menu);

		return "my/board";
	}

	// 강좌 구매를 선택했을 때, 구매 의사를 확인하는 페이지
	@GetMapping("/confirm/{lecIdx}")
	public String confirm(@PathVariable int lecIdx, HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/lec/confirm/{} (GET) 강좌 구매 확인 페이지 진입", lecIdx);

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

		return "my/lec/confirm_buy";
	}

	// 강좌 구매 실행 페이지
	@GetMapping("/execute_buy")
	public String buy_execute(HttpSession session, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/lec/buy (GET) 강좌 구매를 실행합니다.");

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
		MyLecDto LecMyDto = new MyLecDto();
		LecMyDto.setLecIdx(lecIdx);
		LecMyDto.setMemberIdx(memberIdx);
		LecMyDto.setPointHistoryIdx(pointHistoryIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 내 강좌 보관소에 강좌정보를 등록하겠습니다. LecMyDto = {}", LecMyDto);
		myLecDao.insert(LecMyDto);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶ 내 강좌 보관소에 강좌정보를 등록하였습니다.");

		// 세션 비우기
		session.removeAttribute("buyTargetLecIdx");
		return "my/lec/success_buy";
	}

}
