package com.kh.hobbycloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.repository.pay.PaidDao;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired PaidDao paidDao;

	// 결제 목록 및 검색
	@GetMapping("/pay")
	public String payList(@ModelAttribute PaidSearchVO paidSearchVO, Model model) {
		if(paidSearchVO != null) log.debug("ㅡㅡㅡPaidSearchVO 입수: {}", paidSearchVO);
		List<PaidVO> paidList = paidDao.select(paidSearchVO);
		log.debug("ㅡㅡㅡ검색 결과 paidList: {}", paidList);
		model.addAttribute("paidList", paidList);
		return "admin/pay/list";
	}

}
