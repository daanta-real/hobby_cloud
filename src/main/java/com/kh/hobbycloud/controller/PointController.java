package com.kh.hobbycloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.entity.point.PointDto;
import com.kh.hobbycloud.repository.point.PointDao;
import com.kh.hobbycloud.vo.point.PointSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/point")
public class PointController {

	@Autowired PointDao pointDao;

	// 포인트 상품 목록 페이지
	@GetMapping("")
	public String list(PointSearchVO vo, Model model) {
		log.debug("=============== /point GET 포인트상품 목록/검색 페이지 진입. 입력 VO: {}", vo);
		List<PointDto> list = pointDao.select(vo);
		model.addAttribute("list", list);
		return "point/select";
	}

	// 포인트 상품 상세조회 페이지 (여기서는 무조건 idx로만)
	@GetMapping("/detail/{pointIdx}")
	public String detail(@PathVariable int pointIdx, Model model) {
		log.debug("=============== /point/detail/{} GET 포인트상품 상세조회 페이지 진입. 입력 pointIdx: {}", pointIdx);
		PointDto dto = pointDao.getByIdx(pointIdx);
		model.addAttribute("dto", dto);
		return "point/detail/" + pointIdx;
	}

	// 포인트 상품 등록 페이지
	@GetMapping("/insert")
	public String insert() {
		log.debug("=============== /point/insert GET 포인트상품 등록 페이지 진입.");
		return "point/insert";
	}

	// 포인트 상품 등록 처리기
	@PostMapping("/insert")
	public String insert_execute(PointDto dto, Model model) {
		log.debug("=============== /point/insert POST 포인트상품 등록 처리기 진입. 입력 PointDto: {}", dto);
		pointDao.insert(dto);
		log.debug("=============== /point/insert POST 포인트상품 등록이 정상적으로 완료되었습니다.");
		return "redirect:"; // 포인트 목록으로 돌아감
	}

	// 포인트 상품 삭제 처리기
	@GetMapping("/delete/{pointIdx}")
	public String delete(@PathVariable int pointIdx) {
		log.debug("=============== /point/delete/{} GET 포인트상품 삭제 처리기 진입. 입력 pointIdx: {}", pointIdx);
		pointDao.delete(pointIdx);
		return "redirect:select";
	}

	// 포인트 상품 수정 페이지
	@GetMapping("/update/{pointIdx}")
	public String update(@PathVariable int pointIdx, Model model) {
		log.debug("=============== /point/update GET 포인트상품 수정 페이지 진입. 입력 pointIdx: {}", pointIdx);
		PointDto dto = pointDao.getByIdx(pointIdx);
		model.addAttribute("dto", dto);
		return "point/update";
	}

	// 포인트 상품 수정 처리기
	@PostMapping("/update")
	public String udpate_execute(PointDto dto, Model model) {
		log.debug("=============== /point/update POST 포인트상품 수정 처리기 진입. 입력 PointDto: {}", dto);
		pointDao.update(dto);
		return "redirect:"; // 포인트 목록으로 돌아감
	}

}
