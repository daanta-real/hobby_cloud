package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		String memberId = (String)session.getAttribute("memberId");
		int memberIdx = (int) session.getAttribute("memberIdx");
		MemberDto memberDto = memberDao.get(memberId);
		MemberProfileDto memberProfileDto = memberProfileDao.getIdx(memberIdx);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);
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
	
	//프로필 다운로드
	@GetMapping("/profile")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> profile(
				@RequestParam int memberIdx
			) throws IOException {
		
		// 0. 매개변수로 memberIdx가 넘어와 있다.
		System.out.println("ㅡㅡㅡㅡㅡㅡ0. 요청된 memberIdx : " + memberIdx);
		
		// 1. memberIdx를 이용하여, 프로필 이미지 파일정보 전체를 DTO로 갖고 온다.
		MemberProfileDto memberProfileDto = memberProfileDao.getByMemberIdx(memberIdx);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 memberProfileDto : "+memberProfileDto);
		
		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
		String savename = memberProfileDto.getMemberProfileSavename();
		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);
		
		// 3-1. 프로필번호(memberProfileIdx)로 실제 파일 정보를 불러온다
		byte[] data = memberProfileDao.load(savename);
		ByteArrayResource resource = new ByteArrayResource(data);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 3-1. 불러낸 파일 크기: " + data.length);

		// 3-2. 불러낸 파일명을 실제 다운로드 가능한 파일명으로 바꾼다.
		String encodeName = URLEncoder.encode(memberProfileDto.getMemberProfileSavename(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		System.out.println("ㅡㅡㅡㅡㅡㅡ 3-2. 변경된 파일명: " + encodeName);

		return ResponseEntity.ok()
									//.header("Content-Type", "application/octet-stream")
									.contentType(MediaType.APPLICATION_OCTET_STREAM)
									//.header("Content-Disposition", "attachment; filename=\""+이름+"\"")
									.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
									//.header("Content-Encoding", "UTF-8")
									.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
									//.header("Content-Length", String.valueOf(memberProfileDto.getMemberProfileSize()))
									.contentLength(memberProfileDto.getMemberProfileSize())
								.body(resource);
	}

}
