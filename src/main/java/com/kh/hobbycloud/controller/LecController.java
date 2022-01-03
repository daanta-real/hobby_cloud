package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.repository.lec.LecReplyDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

@Controller
@RequestMapping("/lec")
public class LecController {

	@Autowired
	private LecService lecService;
	
	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecFileDao lecFileDao;
	
	@Autowired
	private LecReplyDao lecReplyDao;
	
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
		int lecIdx = lecService.register(lecRegisterVO);
		return "redirect:detail/" + lecIdx;
	}
	
	@GetMapping("/register_success")
	public String register_success() {
		return "lec/register_success";
	}
	
	//상세
	@RequestMapping("/detail/{lecIdx}")
	public String detail(@PathVariable int lecIdx, Model model) {
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		
		List<LecFileDto> list = lecFileDao.getByIdx(lecIdx);
		model.addAttribute("lecDetailVO", lecDetailVO);
		model.addAttribute("list", list);
		
		return "lec/detail";
	}
	
	//강좌 수정
//	@GetMapping("/edit")
//	public String edit(@RequestParam int lecIdx, Model model) {
//		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
//		List<LecFileDto> list = lecFileDao.getByIdx(lecIdx);
//		model.addAttribute("lecDto", lecDto);
//		
////		return "WEB-INF/views/member/edit.jsp";
//		return "lec/edit";
//	}
//	
//	@PostMapping("/edit")
//	public String edit(@ModelAttribute LecDto lecDto, HttpSession session) {
////		lecDto.setMemberId((String)session.getAttribute("ses"));
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
	
	// 파일 전송 실시
	@GetMapping("/lecFile/{lecFileIdx}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@PathVariable int lecFileIdx) throws IOException {

		// 파일 DTO 획득
		LecFileDto lecFileDto = lecFileDao.get(lecFileIdx);

		// 전송할 파일의 데이터 준비
		byte[] data = lecFileDao.load(lecFileIdx);
		ByteArrayResource resource = new ByteArrayResource(data);

		// 보낼 파일명 설정
		String encodeName = URLEncoder.encode(lecFileDto.getLecFileUserName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		// 실제 파일 전송
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
			// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
			.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
			.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
			// .header("Content-Length",
			// String.valueOf(memberProfileDto.getMemberProfileSize()))
			.contentLength(lecFileDto.getLecFileSize()).body(resource);

	}
	

}
