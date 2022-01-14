package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceFileDto;
import com.kh.hobbycloud.repository.place.PlaceDao;
import com.kh.hobbycloud.repository.place.PlaceFileDao;
import com.kh.hobbycloud.service.place.PlaceService;
import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceFileVO;
import com.kh.hobbycloud.vo.place.PlaceListVO;
import com.kh.hobbycloud.vo.place.PlacePageMaker;
import com.kh.hobbycloud.vo.place.PlaceVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/place")
public class PlaceController {
	// 변수준비
	@Autowired
	private PlaceDao placeDao;	
	@Autowired
	private PlaceService placeService;	
	@Autowired	
	private PlaceFileDao placeFileDao;	
	
	// 내 장소 목록 페이지
	@GetMapping("/list")
	public String list(Model model, PlaceCriteria cri) {
		log.debug("ㅡㅡㅡ 장소 목록조회 시작");
		
		List<PlaceListVO> placeListVO = placeService.list(cri);
		model.addAttribute("list", placeListVO);
		
		PlacePageMaker pageMaker = new PlacePageMaker();
		
		pageMaker.setCri(cri);
		int count = placeService.listCount();
		log.debug("장소 목록 수: {}", count);
		
		pageMaker.setTotalCount(count);
		log.debug("pageMaker 정보: {}", pageMaker);
		model.addAttribute("pageMaker",pageMaker);
		
		log.debug("장소 목록으로 이동");
		return "place/list";
	}
	
	//검색
	@PostMapping("/list")
	public String search(@RequestParam String column, @RequestParam String keyword, Model model) {
		model.addAttribute("list",placeDao.search(column, keyword));
		return "place/list";
	}
	
//	// 검색결과 목록 페이지
//	@PostMapping("/list")
//	public String search(@ModelAttribute PlaceSearchVO placeSearchVO, Model model) {
//
//		log.debug("category={}", placeSearchVO);
//		List<PlaceListVO> list = placeDao.listSearch(placeSearchVO);
//		
//
//		model.addAttribute("list",list);
//		return "place/list";
//	}
	
	// 장소 등록 폼 페이지
	@GetMapping("/register")
	public String register() {
		log.debug("ㅡㅡPlaceController - /place/register GET> 장소 등록");		
		
		return "place/register";
	}
	
//	// 장소등록 처리 페이지
//	@PostMapping("/register")
//	public String register(@ModelAttribute PlaceFileVO placeFileVO,HttpSession session) throws IllegalStateException, IOException {
//		log.debug("ㅡㅡPlaceController - /place/register POST> 장소 DATA 입력");
//		int memberIdx = (int) session.getAttribute("memberIdx");
//		log.debug("ㅡㅡPlaceController - /place/register Post> 장소등록 처리");		
//		placeFileVO.setMemberIdx(memberIdx);
//		log.debug("ㅡㅡPlaceController - /place/register placeFileVO"+placeFileVO.toString());		
//		placeService.save(placeFileVO);
//		return "redirect:register_success";
//	}
	
//	// 장소등록 성공 페이지
//	@RequestMapping("/register_success")
//	public String registerSuccess() {
//		log.debug("ㅡㅡPlaceController - /place/register_success REQUEST> 장소 등록 성공");
//		return "place/register_success";
//	}
	
	// 장소 상세 보기
	@RequestMapping("/detail/{placeIdx}")
	public String detail(@PathVariable int placeIdx, Model model) {
		log.debug("ㅡㅡPlaceController - /place/detail REQUEST> 장소 상세보기 시작");
		// 데이터 획득: VO 및 DTO
		PlaceVO placeVO = placeDao.get(placeIdx);
		log.debug("ㅡㅡPlaceController - /place/detail REQUEST> 장소 PlaceVO"+placeVO);
		// 획득된 데이터를 Model에 지정
		List<PlaceFileDto> list = placeFileDao.getListByPlaceIdx(placeIdx);
		model.addAttribute("placeVO", placeVO);
		model.addAttribute("list", list);
				
		// 페이지 리다이렉트 처리
		return "place/detail";
	}
	
	// 장소 삭제 처리 페이지
	@GetMapping("/delete/{placeIdx}")
	public String delete(@RequestParam int placeIdx) {
		placeDao.delete(placeIdx);
		return "redirect:list";
	}

	// 장소 수정 폼 페이지
	@GetMapping("/update/{placeIdx}")
	public String update(@PathVariable int placeIdx, Model model) {
		log.debug("ㅡㅡㅡ /place/update?" + placeIdx + " (장소 파일 수정 GET) 진입");
		
		// 데이터 획득: VO 및 DTO
		PlaceVO placeVO = placeDao.get(placeIdx);
		log.debug("ㅡㅡㅡ PlaceVO: {}", placeVO);
		model.addAttribute("placeVO", placeVO);

		// 획득된 데이터를 Model에 지정
		List<PlaceFileDto> list = placeFileDao.getListByPlaceIdx(placeIdx);
		log.debug("ㅡㅡㅡ List<PlaceFileDto> list = {}", list);
		model.addAttribute("list", list);
		
		log.debug("ㅡㅡㅡ 수정 화면으로 진입합니다.");
		return "place/update";
	}
	
	// 장소 변경 처리 페이지
	@PostMapping("/update/{placeIdx}")
	public String edit(@ModelAttribute PlaceFileVO placeFileVO, MultipartFile attach, HttpSession session) throws IllegalStateException, IOException {
		log.debug("ㅡㅡMemberController - /member/edit POST> 장소 파일 변경 DATA 입력됨.");
		int memberIdx = (int) session.getAttribute("memberIdx");
		placeFileVO.setMemberIdx(memberIdx);
		System.out.println("-------장소 변경 : "+placeFileVO);
		int placeIdx = placeFileVO.getPlaceIdx();
		return "redirect:place/detail/"+ placeIdx;
	}
	
	// 장소 사진 전송 실시
	@GetMapping("/placeFile/{placeFileIdx}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@PathVariable int placeFileIdx) throws IOException {

		// 0. 매개변수로 placeIdx가 넘어와 있다.
		System.out.println("ㅡㅡㅡㅡㅡㅡ 0. 요청된 placeIdx : " + placeFileIdx);
				
		// 파일 DTO 획득
		PlaceFileDto placeFileDto = placeFileDao.getByPlaceFileIdx(placeFileIdx);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 placeFileDto : "+placeFileDto);
		
		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
		String savename = placeFileDto.getPlaceFileServerName();
		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);
		
		// 3-1. 프로필번호(memberProfileIdx)를 이용하여 내가 전송할 실제 파일 정보를 불러온다
		byte[] data = placeFileDao.load(placeFileIdx);
		ByteArrayResource resource = new ByteArrayResource(data);

		// 보낼 파일명 설정
		String encodeName = URLEncoder.encode(placeFileDto.getPlaceFileUserName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		// 실제 파일 전송
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				// .header("Content-Length",
				// String.valueOf(memberProfileDto.getMemberProfileSize()))
				.contentLength(placeFileDto.getPlaceFileSize()).body(resource);

	}

}
