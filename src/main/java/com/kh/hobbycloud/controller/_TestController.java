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

@Slf4j
@Controller
@RequestMapping("/_TEST")
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
