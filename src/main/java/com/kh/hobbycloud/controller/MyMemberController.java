package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.service.my.MyMemberService;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberJoinVO;
import com.kh.hobbycloud.vo.member.MemberPageMaker;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my/member")
public class MyMemberController {

	@Autowired SqlSession sqlSession;
	@Autowired MemberService memberService;
	@Autowired MyMemberService myMemberService;

	@RequestMapping("/")
	public String memberList(MemberCriteria cri, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member 진입");
		List<LinkedHashMap<String, String>> list = myMemberService.list(cri);
		model.addAttribute("list", list);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 전체 Maps 목록: {}개 - {}", list.size(), list);
		MemberPageMaker pageMaker = new MemberPageMaker();
		pageMaker.setCri(cri);
		int count = memberService.listCount();
		pageMaker.setTotalCount(count);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원목록 수: {} / 완성된 페이지네이션 정보: {}", count, pageMaker);
		model.addAttribute("pageMaker", pageMaker);
		return "my/board";
	}

	@RequestMapping("/detail/{memberIdx}")
	public String memberDetail(@PathVariable int memberIdx, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member/detail 진입");
		Map<String, Object> map = myMemberService.detail(memberIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberDto{}", map.get("memberDto"));
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberProfileDto{}", map.get("memberProfileDto"));
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberCategoryDto{}", map.get("memberCategoryDto"));
		model.addAttribute("memberDto", map.get("memberDto"));
		model.addAttribute("memberProfileDto", map.get("memberProfileDto"));
		model.addAttribute("memberCategoryDto", map.get("memberCategoryDto"));
		return "my/detail/member";
	}

	@GetMapping("/update/{memberIdx}")
	public String memberUpdate_form(@PathVariable int memberIdx, Model model) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member/update [GET] 진입");
		Map<String, Object> map = myMemberService.detail(memberIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberDto{}", map.get("memberDto"));
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberProfileDto{}", map.get("memberProfileDto"));
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberCategoryDto{}", map.get("memberCategoryDto"));
		model.addAttribute("memberDto", map.get("memberDto"));
		model.addAttribute("memberProfileDto", map.get("memberProfileDto"));
		model.addAttribute("memberCategoryDto", map.get("memberCategoryDto"));
		return "redirect:/my/member/";
	}

	@PostMapping("/update/{memberIdx}")
	public String memberUpdate_execute(
				@PathVariable int memberIdx,
				@ModelAttribute MemberJoinVO memberJoinVO, MultipartFile attach
			) throws IllegalStateException, IOException {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member/update [POST] 진입:");
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ memberJoinVO = {}", memberJoinVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ attach = {}", attach);
		memberJoinVO.setMemberIdx(memberJoinVO.getMemberIdx());
		memberService.edit(memberJoinVO, attach);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 정보 업데이트 완료");
		return "redirect:/my/member/";
	}

	@GetMapping("/member/delete")
	public String memberDelete(@RequestParam int memberIdx) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ /my/member/delete [GET] 진입:");
		myMemberService.delete(memberIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 회원 삭제 완료");
		return "redirect:/my/member/";
	}

	/*
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
