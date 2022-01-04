package com.kh.hobbycloud.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

// 기능 테스트용 컨트롤러입니다.
// 컨트롤러 관련 테스트하실 분들은 여기서 하세요

@Slf4j
@Controller
@RequestMapping("/test")
public class _TestController {

	// Map 쓰기 테스트용 FORM
	@GetMapping("/mapTest")
	public String mapTest( ) {
		return "_TEST/mapTest";
	}

	// FORM으로부터 Map 읽어오기 테스트
	@ResponseBody
	@PostMapping("/mapTest")
	public String mapTest(@ModelAttribute HashMap<String, Object> map, MultipartFile file) {
		log.debug("ㅡㅡㅡMap size: {}", map.size());
		for(String key: map.keySet()) log.debug("ㅡㅡㅡMap.get({}) = {}", key, map.get(key));
		return null;
	}

}
