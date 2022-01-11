package com.kh.hobbycloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.repository.point.PointHistoryDao;
import com.kh.hobbycloud.vo.point.PointHistorySearchVO;
import com.kh.hobbycloud.vo.point.PointHistoryVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PointHistoryController {

	@Autowired PointHistoryDao pointHistoryDao;

	// 포인트 변동이력 목록 페이지
	@GetMapping("")
	public String list(PointHistorySearchVO vo, Model model) {
		log.debug("=============== /pointHistory GET 포인트 증감이력 목록/검색 페이지 진입. 입력 VO: {}", vo);
		List<PointHistoryVO> list = pointHistoryDao.select(vo);
		model.addAttribute("list", list);
		return "pointHistory/select";
	}

	// 포인트 변동이력 상세조회 페이지 (여기서는 무조건 idx로만)
	@GetMapping("/detail/{pointHistoryIdx}")
	public String detail(@PathVariable int pointHistoryIdx, Model model) {
		log.debug("=============== /pointHistory/detail/{} GET 포인트 증감이력 상세조회 페이지 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx, pointHistoryIdx);
		PointHistoryDto dto = pointHistoryDao.getByIdx(pointHistoryIdx);
		log.debug("=============== /pointHistory/detail/{} GET 뽑아낸 DTO 내용: {}", pointHistoryIdx, dto);
		model.addAttribute("dto", dto);
		return "pointHistory/detail";
	}

	// 포인트 변동이력 등록 페이지
	@GetMapping("/insert")
	public String insert() {
		log.debug("=============== /pointHistory/insert GET 포인트 증감이력 등록 페이지 진입.");
		return "pointHistory/insert";
	}

	// 포인트 변동이력 등록 처리기
	@PostMapping("/insert")
	public String insert_execute(PointHistoryDto dto, Model model) {
		log.debug("=============== /pointHistory/insert POST 포인트 증감이력 등록 처리기 진입. 입력 PointHistoryDto: {}", dto);
		pointHistoryDao.insert(dto);
		log.debug("=============== /pointHistory/insert POST 포인트 증감이력 등록이 정상적으로 완료되었습니다.");
		return "redirect:/pointHistory"; // 포인트 목록으로 돌아감
	}

	// 포인트 변동이력 삭제 처리기
	@GetMapping("/delete/{pointHistoryIdx}")
	public String delete(@PathVariable int pointHistoryIdx) {
		log.debug("=============== /pointHistory/delete/{} GET 포인트 증감이력 삭제 처리기 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx, pointHistoryIdx);
		pointHistoryDao.delete(pointHistoryIdx);
		log.debug("=============== /pointHistory/delete/{} GET 포인트 증감이력 삭제 처리가 정상적으로 완료되었습니다.", pointHistoryIdx, pointHistoryIdx);
		return "redirect:/pointHistory"; // 포인트 목록으로 돌아감
	}

	// 포인트 변동이력 수정 페이지
	@GetMapping("/update/{pointHistoryIdx}")
	public String update(@PathVariable int pointHistoryIdx, Model model) {
		log.debug("=============== /pointHistory/update GET 포인트 증감이력 수정 페이지 진입. 입력 pointHistoryIdx: {}", pointHistoryIdx);
		PointHistoryDto dto = pointHistoryDao.getByIdx(pointHistoryIdx);
		model.addAttribute("dto", dto);
		return "pointHistory/update";
	}

	// 포인트 변동이력 수정 처리기
	@PostMapping("/update")
	public String udpate_execute(PointHistoryDto dto, Model model) {
		log.debug("=============== /pointHistory/update POST 포인트 증감이력 수정 처리기 진입. 입력 PointHistoryDto: {}", dto);
		pointHistoryDao.update(dto);
		log.debug("=============== /pointHistory/update POST 포인트 증감이력 수정 처리가 정상적으로 완료되었습니다.", dto);
		return "redirect:/pointHistory"; // 포인트 목록으로 돌아감
	}


}
