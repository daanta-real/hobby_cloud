package com.kh.hobbycloud.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hobbycloud.repository.pay.LecMyDao;
import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my")
public class MyController {
	@Autowired SqlSession sqlSession;
	@Autowired MemberService memberService;
	@Autowired LecMyDao lecMyDao;

	@RequestMapping("/")
	public String home() {
		return "my/main";
	}

	@RequestMapping("/member")
	public String memberList(@RequestParam MemberCriteria cri, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member 진입");
		List<MemberListVO> list = memberService.list(cri);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ list 목록: {}", list);
		List<String> cols = new ArrayList<>(Arrays.asList(
			"memberIdx", "memberGradeName", "memberId", "memberNick",
			"memberEmail", "memberPhone", "memberRegistered", "memberPoint",
			"memberRegion", "memberGender", "memberCategoryName"
		));
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ cols 목록: {}", cols);
		model.addAttribute("list", list);
		model.addAttribute("cols", cols);
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
