package com.kh.hobbycloud.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my")
public class MyController {

	@Autowired SqlSession sqlSession;

	@RequestMapping("/")
	public String home() {
		return "my/main";
	}

}
