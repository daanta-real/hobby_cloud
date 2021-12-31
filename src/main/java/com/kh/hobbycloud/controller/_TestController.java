package com.kh.hobbycloud.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

// 기능 테스트용 컨트롤러입니다.
// 컨트롤러 관련 테스트하실 분들은 여기서 하세요

@Slf4j
@Controller
@RequestMapping("/test")
public class _TestController {

	@GetMapping("/")
	public String testForm() {
		return "_TEST/_test";
	}

	@PostMapping("/")
	@ResponseBody
	public String testFormReceiver(@RequestParam Map<String, Object> map, Model model) {
		log.debug("◆◆◆◆◆◆◆◆◆◆◆◆◆" + map);
		model.addAttribute("map", map);
		return "_TEST/_test";
	}



}
