package com.kh.hobbycloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.tutor.TutorDao;

@Controller
@RequestMapping("/tutor")
public class TutorController {
	
	@Autowired
	private TutorDao tutorDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//강사 등록
	//현재 로그인한 회원이 강사 신청을 한다음
	//관리자가 승인한다??
	//아니면 session 필요없이 그냥 tutorDto 받아서 관리자가 직접넣기..?
	
	@GetMapping("/insert")
	public String insert(@RequestParam int memberIdx, Model model) {
		MemberDto memberDto = memberDao.getByIdx(memberIdx);
		model.addAttribute("memberDto", memberDto);
		return "tutor/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@RequestParam int memberIdx) {
		//회원 등급 강사로 변경과 동시에
		memberDao.changeGradeTutor(memberIdx);
		//tutor 테이블에 insert
		tutorDao.insert(memberIdx);
		return "redirect:/tutor/insert_success";
	}
	
	//강사 자격 박탈 버튼을 누를경우
	//회원 등급 일반 회원으로 변경과 동시에
	//tutor 테이블에서 delete
	@RequestMapping("/delete")
	public String delete(@RequestParam int memberIdx) {
		memberDao.changeGradeNormal(memberIdx);
		tutorDao.delete(memberIdx);
		return "redirect:/tutor/delete_success";
	}
}
