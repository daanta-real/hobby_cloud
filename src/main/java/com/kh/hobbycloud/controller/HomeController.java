package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

// 사이트 메인화면 등 기본적인 페이지들에 대한 접속 컨트롤러
@Slf4j
@Controller
public class HomeController {

	// 기본 메인 페이지
	@RequestMapping(value = "/")
	public String home() {
		log.debug("ㅡㅡHomeController - /home> home(메인페이지) 접속");
		return "home";
	}

}
