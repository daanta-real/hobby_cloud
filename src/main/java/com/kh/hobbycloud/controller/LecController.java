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
import com.kh.hobbycloud.repository.lec.LecCategoryDao;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
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

	@Autowired
	private LecCategoryDao lecCategoryDao;

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
	public String detail(@PathVariable int lecIdx, HttpSession session, Model model) {
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);

		List<LecFileDto> list = lecFileDao.getListByLecIdx(lecIdx);
		model.addAttribute("lecDetailVO", lecDetailVO);
		model.addAttribute("list", list);

		log.debug("세션 memberIdx = {},", session.getAttribute("memberIdx"));

		//좋아요 구현
		//회원일때 보이고 비회원이면 안보이고
		if(session.getAttribute("memberIdx") != null) {
			LecLikeVO lecLikeVO = new LecLikeVO();
			lecLikeVO.setLecIdx(lecIdx);
			int isLike = 0;

			lecLikeVO.setMemberIdx((Integer)session.getAttribute("memberIdx"));

			int check = lecService.likeCount(lecLikeVO);
			if(check ==0) {
				lecService.likeInsert(lecLikeVO);
			}else if(check==1) {
				isLike = lecService.likeGetInfo(lecLikeVO);
			}

			model.addAttribute("isLike", isLike);
		}

		return "lec/detail";
	}

	// 강좌 수정 폼 페이지 불러오기
	@GetMapping("/edit/{lecIdx}")
	public String update(@PathVariable int lecIdx, Model model) {
		log.debug("ㅡㅡㅡ /lec/edit?" + lecIdx + " (강좌 파일 수정 GET) 진입");

		// 데이터 획득: VO 및 DTO
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		log.debug("ㅡㅡㅡ lecDetailVO: {}", lecDetailVO);
		model.addAttribute("lecDetailVO", lecDetailVO);

		// 데이터 획득: 카테고리 목록
		List<String> lecCategoryList = lecCategoryDao.select();
		model.addAttribute("lecCategoryList", lecCategoryList);

		// 획득된 데이터를 Model에 지정
		List<LecFileDto> fileList = lecFileDao.getListByLecIdx(lecIdx);
		log.debug("ㅡㅡㅡ List<LecFileDto> list = {}", fileList);
		model.addAttribute("list", fileList);

		log.debug("ㅡㅡㅡ 수정 화면으로 진입합니다.");
		return "lec/edit";
	}

	// 강좌 삭제
	@GetMapping("/delete/{lecIdx}")
	public String delete(@PathVariable int lecIdx) {
		lecDao.delete(lecIdx);
		return "redirect:list";
	}

	// 파일 전송 다운로드 (파일 전송 실시)
	@GetMapping("/lecFile/{lecFileIdx}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@PathVariable int lecFileIdx) throws IOException {

		// 0. 매개변수로 lecIdx가 넘어와 있다.
		System.out.println("ㅡㅡㅡㅡㅡㅡ0. 요청된 lecIdx : " + lecFileIdx);

		// 1. lecIdx를 이용하여, 이미지 파일정보 전체를 DTO로 갖고 온다.
		LecFileDto lecFileDto = lecFileDao.getByLecFileIdx(lecFileIdx);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 lecFileDto : "+lecFileDto);

		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
		String savename = lecFileDto.getLecFileServerName();
		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);

		// 3-1. 프로필번호(memberProfileIdx)를 이용하여 내가 전송할 실제 파일 정보를 불러온다
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
