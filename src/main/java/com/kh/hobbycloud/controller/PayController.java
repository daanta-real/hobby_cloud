package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.vo.pay.KakaoPayReadyResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pay")
public class PayController {

	// 카카오페이 진입 페이지
	@RequestMapping("/")
	public String index() {
		log.debug("================== index(GET)");
		return "pay/home";
	}

	// 카카오페이 결제내용 선확인 페이지
	@GetMapping("/confirm")
	public String confirm() {
		log.debug("================== confirm(GET)");
		return "pay/confirm";
	}

	// 본격 결제 진행 페이지.
	// 카카오페이 결제내용 선확인 페이지로부터 결제 내용이 넘어옴.
	@PostMapping("/confirm")
	public String confirm(@ModelAttribute KakaoPayReadyResponseVO requestVo) {
		log.debug("================== confirm(POST) 진입. requestVo = {]", requestVo);
		return "redirect:";
	}

	// 카카오페이 성공 페이지
	@ResponseBody
	@RequestMapping("/success")
	public String success() {
		log.debug("================== success(GET)");
		return "pay/success";
	}

	// 카카오페이 실패 페이지
	@ResponseBody
	@RequestMapping("/fail")
	public String fail() {
		log.debug("================== fail(GET)");
		return "pay/fail";
	}

}
