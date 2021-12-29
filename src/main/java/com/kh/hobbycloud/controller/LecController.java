package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

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

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

@Controller
@RequestMapping("/lec")
public class LecController {

	@Autowired
	private LecService lecService;
	
	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecFileDao lecFileDao;
	
	//목록(검색 가능)
	@RequestMapping("/list")
	public String search(@RequestParam Map<String ,Object> param , Model model) {
		List<LecDto> listSearch = lecDao.listSearch(param);
		model.addAttribute("listSearch", listSearch);
		return "lec/list";
	}
	
	@GetMapping("/register")
	public String insert() {
		return "lec/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException {
//		session.setAttribute("tutorIdx", lecRegisterVO.getTutorIdx());
		lecService.register(lecRegisterVO);
		return "redirect:register_success";
	}
	
	@GetMapping("/register_success")
	public String register_success() {
		return "lec/register_success";
	}
	
	//상세
	@RequestMapping("/detail")
	public String detail(@RequestParam int lecIdx, Model model) {
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		LecFileDto lecFileDto = lecFileDao.getByIdx(lecIdx);
		model.addAttribute("lecDetailVO", lecDetailVO);
		model.addAttribute("lecFileDto", lecFileDto);
		return "lec/detail";
	}
	
	//강좌 수정
//	@GetMapping("/edit")
//	public String edit(@RequestParam int lecIdx, Model model) {
//		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
//		
//		model.addAttribute("lecDto", lecDto);
//		
////		return "WEB-INF/views/member/edit.jsp";
//		return "lec/edit";
//	}
//	
//	@PostMapping("/edit")
//	public String edit(@ModelAttribute LecDto lecDto, HttpSession session) {
//		lecDto.setMemberId((String)session.getAttribute("ses"));
//		boolean result = memberDao.changeInformation(memberDto);
//		if(result) {
//			return "redirect:edit_success";
//		}
//		else {
//			return "redirect:edit?error";
//		}
//		
//	}

	// 강좌 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int lecIdx) {
		lecDao.delete(lecIdx);
		return "redirect:list";
	}
	
	//프로필 다운로드
//	@GetMapping("/lecfile")
//	@ResponseBody
//	public ResponseEntity<ByteArrayResource> lecfile(
//				@RequestParam int lecIdx
//			) throws IOException {
//		
//		// 0. 매개변수로 lecIdx가 넘어와 있다.
//		System.out.println("ㅡㅡㅡㅡㅡㅡ0. 요청된 lecIdx : " + lecIdx);
//		
//		// 1. lecIdx를 이용하여, 이미지 파일정보 전체를 DTO로 갖고 온다.
//		LecFileDto lecFileDto = lecFileDao.getByIdx(lecIdx);
//		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 lecFileDto : "+lecFileDto);
//		
//		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
//		String savename = lecFileDto.getLecFileServerName();
//		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);
//		
//		// 3-1. 프로필번호(memberProfileIdx)로 실제 파일 정보를 불러온다
//		byte[] data = lecFileDao.load(savename);
//		ByteArrayResource resource = new ByteArrayResource(data);
//		System.out.println("ㅡㅡㅡㅡㅡㅡ 3-1. 불러낸 파일 크기: " + data.length);
//
//		// 3-2. 불러낸 파일명을 실제 다운로드 가능한 파일명으로 바꾼다.
//		String encodeName = URLEncoder.encode(memberProfileDto.getMemberProfileSavename(), "UTF-8");
//		encodeName = encodeName.replace("+", "%20");
//		System.out.println("ㅡㅡㅡㅡㅡㅡ 3-2. 변경된 파일명: " + encodeName);
//
//		return ResponseEntity.ok()
//									//.header("Content-Type", "application/octet-stream")
//									.contentType(MediaType.APPLICATION_OCTET_STREAM)
//									//.header("Content-Disposition", "attachment; filename=\""+이름+"\"")
//									.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
//									//.header("Content-Encoding", "UTF-8")
//									.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
//									//.header("Content-Length", String.valueOf(memberProfileDto.getMemberProfileSize()))
//									.contentLength(memberProfileDto.getMemberProfileSize())
//								.body(resource);
//	}
}
