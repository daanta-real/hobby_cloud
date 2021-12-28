package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

@Controller
@RequestMapping("/lec")
public class LecController {

	@Autowired
	private LecService lecService;
	
	@Autowired
	private LecDao lecDao;
	
	@GetMapping("/list")
	public String list(Model model) {
		List<LecDto> list = lecDao.list();
		model.addAttribute("list", list);
		return "lec/list";
	}

	@PostMapping("/list")
	public String search(@RequestParam Map<String ,Object> param, Model model) {
		List<LecDto> list = lecDao.listSearch(param);
		System.out.println(param+"ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
		model.addAttribute("list", list);
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
