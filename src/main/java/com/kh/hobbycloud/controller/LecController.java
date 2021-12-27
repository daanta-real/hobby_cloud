package com.kh.hobbycloud.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

@Controller
@RequestMapping("/lec")
public class LecController {

	@Autowired
	private LecService lecService;
	
	@GetMapping("/list")
	public String list() {
		return "lec/list";
	}
	
	@GetMapping("/register")
	public String insert() {
		return "lec/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute LecRegisterVO lecRegisterVO, HttpSession session) throws IllegalStateException, IOException {
		session.setAttribute("tutorIdx", lecRegisterVO.getTutorIdx());
		lecService.register(lecRegisterVO);
		return "redirect:join_success";
	}

}
