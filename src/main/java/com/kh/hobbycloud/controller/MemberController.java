package com.kh.hobbycloud.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.member.MemberProfileDao;
import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;	

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberProfileDao memberProfileDao;

	@GetMapping("/login")
	public String login() {
		return "member/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession session) {
		//회원정보 단일조회 및 비밀번호 일치판정
		MemberDto findDto = memberDao.login(memberDto);
		if(findDto != null) {
			//세션에 Idx, Id, Nick, grade를 설정하고 root로 리다이렉트
			session.setAttribute("memberIdx", findDto.getMemberIdx());
			session.setAttribute("memberId", findDto.getMemberId());
			session.setAttribute("memberNick", findDto.getMemberNick());
			session.setAttribute("memberGrade",findDto.getMemberGradeName());
			return "redirect:/";
		}
		else {
			return "redirect:login?error";
		}
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("memberIdx");
		session.removeAttribute("memberId");
		session.removeAttribute("memberNick");
		session.removeAttribute("memberGrade");
		
		return "redirect:/";
	}
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		memberService.join(memberJoinVO);
		return "redirect:join_success";
	}

	@RequestMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}
	
	//내정보
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		int memberIdx = (int)session.getAttribute("memberIdx");
		MemberDto memberDto = memberDao.get(memberIdx);
		MemberProfileDto memberProfileDto = memberProfileDao.getMemberIdx(memberIdx);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}
	
//	비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "member/password";
	}

	@PostMapping("/password")
	public String password(
			@RequestParam String memberPw, 
			@RequestParam String changePw, 
			HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");

		boolean result = memberDao.changePassword(memberId, memberPw, changePw);
		if(result) {
			return "redirect:password_success";
		}
		else {
			return "redirect:password?error";
		}
	}

	@RequestMapping("/password_success")
	public String passwordSuccess() {
		return "member/password_success";
	}

//개인정보 변경
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberDao.get(memberId);

		model.addAttribute("memberDto", memberDto);

		return "member/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		memberDto.setMemberId(memberId);

		boolean result = memberDao.changeInformation(memberDto);
		if(result) {
			return "redirect:edit_success";
		}
		else {
			return "redirect:edit?error";
		}
	}

	@RequestMapping("/edit_success")
	public String editSuccess() {
		return "member/edit_success";
	}
	
	//회원 탈퇴
	@GetMapping("/quit")
	public String quit() {
		return "member/quit";
	}

	@PostMapping("/quit")
	public String quit(HttpSession session, @RequestParam String memberPw) {
		String memberId = (String)session.getAttribute("memberId");

		boolean result = memberDao.quit(memberId, memberPw);
		if(result) {
			session.removeAttribute("memberIdx");
			session.removeAttribute("memberId");
			session.removeAttribute("memberNick");
			session.removeAttribute("memberGrade");

			return "redirect:quit_success";
		}
		else {
			return "redirect:quit?error";
		}
	}

	@RequestMapping("/quit_success")
	public String quitSuccess() {
		return "member/quit_success";
	}

}
