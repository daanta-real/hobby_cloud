package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	// 결제 목록
	@RequestMapping("/pay")
	public String payList() {
		return "pay/list";
	}

}
