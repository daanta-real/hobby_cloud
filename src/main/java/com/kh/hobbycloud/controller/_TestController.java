package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.entity._test._TestDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/_TEST")
public class _TestController {

	@GetMapping("/1")
	public String testStart() {
		return "_TEST/_test";
	}

	@PostMapping("/1")
	@ResponseBody
	public String a(@ModelAttribute("testform") _TestDto testDto, Model model) {
		String result = testDto.toString();
		log.warn(result);
		model.addAttribute("dto", testDto);
		return "_TEST/_test";
	}

}
