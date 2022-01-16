package com.kh.hobbycloud.controller;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.service.my.MyMemberService;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberPageMaker;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my")
public class MyController {

	@Autowired SqlSession sqlSession;
	@Autowired MemberService memberService;
	@Autowired MyMemberService myMemberService;

	@RequestMapping("/")
	public String home() {
		return "my/main";
	}

	@RequestMapping("/member")
	public String memberList(MemberCriteria cri, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member 진입");
		List<LinkedHashMap<String, String>> list = myMemberService.list(cri);
		model.addAttribute("list", list);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 전체 Maps 목록: {}", list);
		MemberPageMaker pageMaker = new MemberPageMaker();
		pageMaker.setCri(cri);
		int count = memberService.listCount();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원목록 수: {} / 완성된 페이지네이션 정보: {}", count, pageMaker);
		model.addAttribute("pageMaker",pageMaker);
		return "my/board";
	}

/*
	@RequestMapping("/member/detail")
	public String memberDetail() {
		return "my/member/detail";
	}

	@GetMapping("/member/update")
	public String memberUpdate_form() {
		return "my/member/udpate";
	}

	@PostMapping("/member/update")
	public String memberUpdate_execute() {
		return "my/member/";
	}

	@GetMapping("/member/delete")
	public String memberDelete(@RequestParam int memberIdx) {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(memberIdx);
		sqlSession.update("member.update", memberIdx);
		return "my/main";
	}

	@RequestMapping("/lec/myLec")
	public String myLecList() {
		return "my/lec/myLec";
	}

	@RequestMapping("/")
	public String myLec() {
		return "my/main";
	}

	//내 강좌 보기
	@GetMapping("/lecMy")
	public String myLec(HttpSession session, Model model) {
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		List<LecMyVO> myLecList = lecMyDao.getMyLec(memberIdx);
		model.addAttribute("myLecList", myLecList);
		return "lecMy/my_lec";
	}
*/
}
