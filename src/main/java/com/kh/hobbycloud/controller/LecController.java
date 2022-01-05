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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	@GetMapping("/edit")
	public String edit(@RequestParam int lecIdx, Model model) {
		log.debug("ㅡㅡㅡ /lec/edit?" + lecIdx + " (강좌 파일 수정 GET) 진입");

		// 강좌 정보 불러오기
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		log.debug("ㅡㅡㅡ lecDetailVO: {}", lecDetailVO);
		model.addAttribute("lecDetailVO", lecDetailVO);

		// 해당 강좌의 파일들 정보 불러오기
		List<LecFileDto> lecFileDto = lecFileDao.getByLecIdx_list(lecIdx);
		log.debug("ㅡㅡㅡ lecFileDto = {}", lecFileDto);
		model.addAttribute("lecFileDto", lecFileDto);

		return "lec/edit";
	}

	// 강좌 수정 처리
	// map에는 fileList와 lecDetailVO가 넘어온다.
	@PostMapping("/edit")
	public String edit(@ModelAttribute Map<String, Object> map, Model model, HttpSession session) {

		// 넘어온 파일정보를 모델로 넘김
		List<String> filesList = (List<String>) map.get("filesList");
		log.debug("ㅡㅡㅡ filesList = {}", filesList);

		// 수정된 글정보를 갖고옴
		LecDetailVO lecDetailVO = (LecDetailVO) map.get("lecDetailVO");
		log.debug("ㅡㅡㅡ lecDetailVO = {}", lecDetailVO);

		return "lec/list";
	}

	// 강좌 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int lecIdx) {
		lecDao.delete(lecIdx);
		return "redirect:list";
	}

	//파일 다운로드
	@GetMapping("/lecfile")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> lecfile(
				@RequestParam int lecIdx
			) throws IOException {

		// 0. 매개변수로 lecIdx가 넘어와 있다.
		System.out.println("ㅡㅡㅡㅡㅡㅡ0. 요청된 lecIdx : " + lecIdx);

		// 1. lecIdx를 이용하여, 이미지 파일정보 전체를 DTO로 갖고 온다.
		LecFileDto lecFileDto = lecFileDao.getByIdx(lecIdx);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 lecFileDto : "+lecFileDto);

		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
		String savename = lecFileDto.getLecFileServerName();
		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);

		// 3-1. 프로필번호(memberProfileIdx)로 실제 파일 정보를 불러온다
		byte[] data = lecFileDao.load(lecIdx);
		ByteArrayResource resource = new ByteArrayResource(data);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 3-1. 불러낸 파일 크기: " + data.length);

		// 3-2. 불러낸 파일명을 실제 다운로드 가능한 파일명으로 바꾼다.
		String encodeName = URLEncoder.encode(lecFileDto.getLecFileServerName(), "UTF-8");
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
									.contentLength(lecFileDto.getLecFileSize())
								.body(resource);
	}
}
