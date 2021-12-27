package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/pay")
public class PayController {

	// 카카오페이 진입 페이지
	@ResponseBody
	@RequestMapping("/")
	public String index() {
		return "pay/home";
	}

	// 카카오페이 결제내용 선확인 페이지
	@ResponseBody
	@RequestMapping("/confirm")
	public String confirm() {
		return "pay/confirm";
	}

	// 카카오페이 성공 페이지
	@ResponseBody
	@RequestMapping("/success")
	public String success() {
		return "pay/success";
	}

	// 카카오페이 실패 페이지
	@ResponseBody
	@RequestMapping("/fail")
	public String fail() {
		return "pay/fail";
	}

}
