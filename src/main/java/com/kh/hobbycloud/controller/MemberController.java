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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {

	// 변수 선언
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberProfileDao memberProfileDao;

	// 로그인 폼 페이지
	@GetMapping("/login")
	public String login() {
		log.debug("ㅡㅡMemberController - /member/login GET> 로그인");
		return "member/login";
	}

	// 로그인 처리 페이지
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession session) {

		// 0. 입력된 값 확인: DTO에 ID와 PW가 있어야 됨
		log.debug("ㅡㅡMemberController - /member/login POST> 로그인 시도: ID = " + memberDto.getMemberId() + " / PW = " + memberDto.getMemberPw());

		// 1. 입력한 ID / PW 조합에 일치하는 회원정보를 찾아봄.
		MemberDto foundDto = memberDao.login(memberDto);
		log.debug("ㅡㅡMemberController - /member/login POST> 조회된 DTO: " + foundDto);

		// 2. 조회 결과에 따른 후속처리
		// 2-1. 일치하는 것이 있으면, 로그인 진행
		if(foundDto != null) {

			log.debug("ㅡㅡMemberController - /member/login POST> 로그인 성공. (No.{} {}({}) - {}등급)",
				foundDto.getMemberIdx(),  foundDto.getMemberId(),
				foundDto.getMemberNick(), foundDto.getMemberGradeName()
			);

			// 세션에 Idx, Id, Nick, grade를 설정하고 root로 리다이렉트
			session.setAttribute("memberIdx"  , foundDto.getMemberIdx());
			session.setAttribute("memberId"   , foundDto.getMemberId());
			session.setAttribute("memberNick" , foundDto.getMemberNick());
			session.setAttribute("memberGrade", foundDto.getMemberGradeName());
			
			return "redirect:/";

		}

		// 2-2. 일치하는 것이 없으면, 로그인 폼 페이지로 돌아감
		else {
			log.debug("ㅡㅡMemberController - /member/login POST> 로그인 실패.");
			return "redirect:login?error";
		}

	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {

		// 세션 다 뺌.
		log.debug("ㅡㅡMemberController - /member/logout REQUEST> 로그아웃");
		session.removeAttribute("memberIdx");
		session.removeAttribute("memberId");
		session.removeAttribute("memberNick");
		session.removeAttribute("memberGrade");

		return "redirect:/";

	}

	// 회원가입 폼 페이지
	@GetMapping("/join")
	public String join() {
		log.debug("ㅡㅡMemberController - /member/join GET> 회원가입");
		return "member/join";
	}

	// 회원가입 처리 페이지
	@PostMapping("/join")
	public String join(@ModelAttribute MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		log.debug("ㅡㅡMemberController - /member/join POST> 회원가입 DATA 입력됨");
		memberService.join(memberJoinVO);
		log.debug("ㅡㅡMemberController - /member/join POST> 회원가입 DATA 입력됨");
		return "redirect:join_success";
	}

	// 회원가입 성공 페이지
	@RequestMapping("/join_success")
	public String joinSuccess() {
		log.debug("ㅡㅡMemberController - /member/join_success REQUEST> 회원가입 성공");
		return "member/join_success";
	}

	// 마이페이지 (임시용)
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		log.debug("ㅡㅡMemberController - /member/mypage REQUEST> 마이페이지");
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		MemberDto memberDto = memberDao.get(memberIdx);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}


	// 비밀번호 변경 폼 페이지
	@GetMapping("/password")
	public String password() {
		log.debug("ㅡㅡMemberController - /member/password GET> 비밀번호 변경 페이지");
		return "member/password";
	}

	// 비밀번호 변경 처리 페이지
	@PostMapping("/password")
	public String password(
			@RequestParam String memberPw,
			@RequestParam String changePw,
			HttpSession session) {
		log.debug("ㅡㅡMemberController - /member/password POST> 비밀번호 변경 DATA 들어옴");
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");

		boolean result = memberDao.changePassword(memberIdx, memberPw, changePw);
		if(result) {
			return "redirect:password_success";
		}
		else {
			return "redirect:password?error";
		}
	}

	// 비밀번호 변경 성공 페이지
	@RequestMapping("/password_success")
	public String passwordSuccess() {
		log.debug("ㅡㅡMemberController - /member/password_success REQUEST> 비밀번호 변경 성공.");
		return "member/password_success";
	}

	// 개인정보 변경 폼 페이지
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		log.debug("ㅡㅡMemberController - /member/edit GET> 회원정보 변경");
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberDao.get(memberId);

		model.addAttribute("memberDto", memberDto);

		return "member/edit";
	}

	// 개인정보 변경 처리 페이지
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session) {
		log.debug("ㅡㅡMemberController - /member/edit POST> 회원정보 변경 DATA 입력됨");
		String memberId = (String)session.getAttribute("memberId");
		memberDto.setMemberId(memberId);

		boolean result = memberDao.changeInformation(memberDto);
		if(result) {
			return "redirect:edit_success";
		}
		else {
			log.debug("ㅡㅡMemberController - /member/edit?error GET> 회원정보 변경 실패");
			return "redirect:edit?error";
		}
	}

	// 개인정보 변경 성공 페이지
	@RequestMapping("/edit_success")
	public String editSuccess() {
		log.debug("ㅡㅡMemberController - /member/edit_success> 회원정보 변경 성공.");
		return "member/edit_success";
	}

	// 회원 탈퇴 폼 페이지 (비밀번호 입력받는 폼 페이지 출력)
	@GetMapping("/quit")
	public String quit() {
		log.debug("ㅡㅡMemberController - /member/quit GET> 회원 탈퇴");
		return "member/quit";
	}

	// 회원 탈퇴 처리 페이지
	@PostMapping("/quit")
	public String quit(HttpSession session, @RequestParam String memberPw) {
		log.debug("ㅡㅡMemberController - /member/quit POST> 회원 탈퇴 DATA 입력됨");
		Integer memberIdx = (Integer) session.getAttribute("memberIdx");

		boolean result = memberDao.quit(memberIdx, memberPw);
		if(result) {
			session.removeAttribute("memberIdx");
			session.removeAttribute("memberId");
			session.removeAttribute("memberNick");
			session.removeAttribute("memberGrade");

			return "redirect:quit_success";
		}
		else {
			log.debug("ㅡㅡMemberController - /member/quit?error GET> 회원 탈퇴 실패");
			return "redirect:quit?error";
		}
	}

	// 회원탈퇴 성공 페이지
	@RequestMapping("/quit_success")
	public String quitSuccess() {
		log.debug("ㅡㅡMemberController - /member/quit_success REQUEST> 회원 탈퇴 성공.");
		return "member/quit_success";
		// views/member/quit_success.jsp 페이지에 메인페이지로 가는 버튼도 제공했으면 좋겠네요
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
