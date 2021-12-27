package com.kh.hobbycloud.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.repository.gather.GatherDao;

@Controller
@RequestMapping("/gather")
public class GatherController {

	@Autowired
	private GatherDao gatherDao;

	@RequestMapping("/list")
	public String list(Model model) {
		List<GatherDto> list = gatherDao.list();
		model.addAttribute("list", list);
		return "gather/list";
	}

//	@RequestMapping("/search")
//	public ModelAndView search(@RequestParam Map<String ,Object> param, Model model) {
//		System.out.println(param+"ㅡㅡㅡㅡㅡㅡㅡㅡ");
//		List<GatherDto> list = gatherDao.listSearch(param);
//
//		model.addAttribute("list",list);
//		return "gather/search";
//	}

	@GetMapping("/insert")
	public String insert() {
		return "gather/insert";
	}

	@PostMapping("/insert")
	public String insert(@ModelAttribute GatherDto gatherDto) {
		gatherDao.insert(gatherDto);
		return "redirect:list";
	}
	
}