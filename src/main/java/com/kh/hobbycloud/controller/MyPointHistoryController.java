package com.kh.hobbycloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.vo.point.PointHistorySearchVO;
import com.kh.hobbycloud.vo.point.PointHistoryVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my/hist")
public class MyPointHistoryController {

	@Autowired PointHistoryDao pointHistoryDao;

	// 포인트 변동이력 목록 페이지
	@GetMapping("/")
	public String list(PointHistorySearchVO vo, HttpSession session, Model model) {
		log.debug("=============== /my/hist/ GET 포인트 증감이력 목록/검색 페이지 진입. 입력 VO: {}", vo);
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		boolean isLoggedIn = memberIdx != null;
		boolean isAdmin
			=  isLoggedIn
			&& session.getAttribute("memberGrade") != null
			&& session.getAttribute("memberGrade").equals("관리자");
		if(!isAdmin) vo.setMemberIdx((int) session.getAttribute("memberIdx"));
		List<PointHistoryVO> list = pointHistoryDao.select(vo);
		for(PointHistoryVO p: list)
			log.debug("=============== /my/hist/ GET 포인트 증감이력 목록/검색 결과: {}", p);
		model.addAttribute("list", list);
		return "my/hist/select";
	}

	// 포인트 변동이력 상세조회 페이지 (여기서는 무조건 idx로만)
	@GetMapping("/detail/{pointHistoryIdx}")
	public String detail(@PathVariable int pointHistoryIdx, Model model) {
		log.debug("=============== /my/hist/detail/{} GET 포인트 증감이력 상세조회 페이지 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx, pointHistoryIdx);
		PointHistoryDto dto = pointHistoryDao.getByIdx(pointHistoryIdx);
		log.debug("=============== /my/hist/detail/{} GET 뽑아낸 DTO 내용: {}", pointHistoryIdx, dto);
		model.addAttribute("dto", dto);
		return "my/hist/detail";
	}

	// 포인트 변동이력 등록 페이지
	@GetMapping("/insert")
	public String insert() {
		log.debug("=============== /my/hist/insert GET 포인트 증감이력 등록 페이지 진입.");
		return "my/hist/insert";
	}

	// 포인트 변동이력 등록 처리기 (포인트결제, 선물 등 모든 타입 이거 하나로 대응함)
	@PostMapping("/insert")
	public String insert_execute(@ModelAttribute PointHistoryDto pointHistoryDto, Model model) {
		log.debug("=============== /my/hist/insert POST 포인트 증감이력 등록 처리기 진입. 입력 PointHistoryDto: {}", pointHistoryDto);
		pointHistoryDao.insert(pointHistoryDto);
		log.debug("=============== /my/hist/insert POST 포인트 증감이력 등록 처리기가 정상적으로 실행 완료되었습니다.");
		return "redirect:/"; // 포인트 목록으로 돌아감
	}

	// 포인트 변동이력 삭제 처리기
	@GetMapping("/delete/{pointHistoryIdx}")
	public String delete(@PathVariable int pointHistoryIdx) {
		log.debug("=============== /my/hist/delete/{} GET 포인트 증감이력 삭제 처리기 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx, pointHistoryIdx);
		pointHistoryDao.delete(pointHistoryIdx);
		log.debug("=============== /my/hist/delete/{} GET 포인트 증감이력 삭제 처리가 정상적으로 완료되었습니다.", pointHistoryIdx, pointHistoryIdx);
		return "redirect:/"; // 포인트 목록으로 돌아감
	}

	// 포인트 변동이력 수정 페이지
	@GetMapping("/update/{pointHistoryIdx}")
	public String update(@PathVariable int pointHistoryIdx, Model model) {
		log.debug("=============== /my/hist/update GET 포인트 증감이력 수정 페이지 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx);
		PointHistoryDto dto = pointHistoryDao.getByIdx(pointHistoryIdx);
		model.addAttribute("dto", dto);
		return "my/hist/update";
	}

	// 포인트 변동이력 수정 처리기
	@PostMapping("/update")
	public String udpate_execute(PointHistoryDto dto, Model model) {
		log.debug("=============== /my/hist/update POST 포인트 증감이력 수정 처리기 진입. 입력 PointHistoryDto: {}", dto);
		pointHistoryDao.update(dto);
		log.debug("=============== /my/hist/update POST 포인트 증감이력 수정 처리가 정상적으로 완료되었습니다.", dto);
		return "redirect:/"; // 포인트 목록으로 돌아감
	}


}
