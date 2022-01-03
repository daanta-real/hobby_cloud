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

	// (아무 내용 없음) 카카오페이 초기 진입 페이지
	@RequestMapping("/")
	public String index() {
		log.debug("================== index(GET)");
		return "pay/home";
	}

	// 결제 내용 확인 후 QR코드 찍으러 가는 페이지
	@GetMapping("/confirm")
	public String confirm() {
		log.debug("================== confirm(GET)");
		return "pay/confirm"; // QR코드 찍으러 카카오페이로 보낸 다음, TID를 받아와서 confirm을 호출하는 페이지
	}

	// QR코드 찍고
	@PostMapping("/confirm")
	public String confirm(@ModelAttribute KakaoPayReadyResponseVO requestVo) {
		log.debug("================== confirm(POST) 진입. requestVo = {]", requestVo);
		return "redirect:"; // test03으로 감. 여기서
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
