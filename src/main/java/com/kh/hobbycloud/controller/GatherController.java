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

import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.entity.gather.GatherHeadsDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.repository.gather.GatherHeadsDao;
import com.kh.hobbycloud.service.gather.GatherService;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.GatherFileVO;
import com.kh.hobbycloud.vo.gather.GatherHeadsVO;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;
import com.kh.hobbycloud.vo.gather.PageMaker;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/gather")
public class GatherController {

	// 변수준비
	@Autowired
	private GatherDao gatherDao;
	@Autowired
	private GatherService gatherService;
	@Autowired
	private GatherFileDao gatherFileDao;
	@Autowired
	private GatherHeadsDao gatherHeadsDao;

//	// 일반 목록 페이지
//	@GetMapping("/list")
//	public String list(Model model) {
//		List<GatherVO> list = gatherDao.list();
//		model.addAttribute("list", list);
//		System.out.println(list);
//		return "gather/list";
//	}

	@GetMapping("/list")
	public String list(Model model,Criteria cri) {
		
		
		model.addAttribute("list", gatherService.list(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(gatherService.listCount());
		model.addAttribute("pageMaker",pageMaker);
		
		System.out.println(gatherService.list(cri));
		return "gather/list";
	}
	// 검색결과 목록 페이지
	@PostMapping("/list")
	public String search(@ModelAttribute GatherSearchVO gatherSearchVO, Model model) {
//		log.debug("param.toString()   " + gatherSearchDto.toString());
		log.debug("category={}", gatherSearchVO);
		List<GatherVO> list = gatherDao.listSearch(gatherSearchVO);
		

		model.addAttribute("list",list);
		return "gather/list";
	}

	// 모임글 등록 폼 페이지
	@GetMapping("/insert")
	public String insert() {
		return "gather/insert";
	}

	// 모임글 등록 실시
	@PostMapping("/insert")
	public String insert(@ModelAttribute GatherFileVO gatherFileVO) throws IllegalStateException, IOException {
		System.out.println("ㅡㅡ 모임글 등록 실시. 모임 정보: " + gatherFileVO);
		int gatherIdx = gatherService.save(gatherFileVO);
		return "redirect:detail/" + gatherIdx;	
	}																

	// 상세 보기 페이지
	@RequestMapping("/detail/{gatherIdx}")
	public String detail(@PathVariable int gatherIdx, Model model,HttpSession session) {

		// 데이터 획득: VO 및 DTO
		GatherVO gatherVO = gatherDao.get(gatherIdx);

		// 획득된 데이터를 Model에 지정
		List<GatherFileDto> list = gatherFileDao.getIdx(gatherIdx);
		
		//참가자 조회
		List<GatherHeadsVO> list2 = gatherHeadsDao.list(gatherIdx);
		
		//소모임 참가자 조회
		model.addAttribute("list2",list2);
		
		//게시판 정보 조회
		model.addAttribute("GatherVO", gatherVO);
		//게시판 사진 조회
		model.addAttribute("list", list);

		// 페이지 리다이렉트 처리
		return "gather/detail";
	}
	
		//소모임 참가
		@RequestMapping("/join")
		public String join(@RequestParam int gatherIdx,HttpSession session) {
			int memberIdx = (int) session.getAttribute("memberIdx");
			GatherHeadsDto gatherHeadsDto = new GatherHeadsDto();
			gatherHeadsDto.setGatherIdx(gatherIdx);
			gatherHeadsDto.setMemberIdx(memberIdx);
			gatherHeadsDao.join(gatherHeadsDto);
			return "redirect:detail/"+gatherIdx;
		}

	//소모임 취소
	@GetMapping("/cancel")
	public String cancel(@RequestParam int gatherIdx,HttpSession session) {
		int memberIdx = (int) session.getAttribute("memberIdx");
		GatherHeadsDto gatherHeadsDto = new GatherHeadsDto();		
		gatherHeadsDto.setGatherIdx(gatherIdx);
		gatherHeadsDto.setMemberIdx(memberIdx);
		 gatherHeadsDao.cancel(gatherHeadsDto);
		 return "redirect:detail/"+gatherIdx;
	}
	// 글 삭제 실시
	@GetMapping("/delete")
	public String delete(@RequestParam int gatherIdx) {
		gatherDao.delete(gatherIdx);
		return "redirect:list";
	}

	// 글 수정 폼 페이지/update/123
	@GetMapping("/update/{gatherIdx}")
	public String update(@PathVariable int gatherIdx, Model model) {

		// 데이터 획득: VO 및 DTO
		GatherVO gatherVO = gatherDao.get(gatherIdx);

		// 획득된 데이터를 Model에 지정
		List<GatherFileDto> list = gatherFileDao.getIdx(gatherIdx);
		model.addAttribute("GatherVO", gatherVO);
		model.addAttribute("list", list);

		return "gather/update";
	}

	// 글 수정 실시
	@PostMapping("/update/{gatherIdx}")
	public String update2(@ModelAttribute GatherFileVO gatherFileVO) throws IllegalStateException, IOException {

		// 수정
		gatherService.update(gatherFileVO);
		int gatherIdx = gatherFileVO.getGatherIdx();
		return "redirect:/gather/detail/" + gatherIdx;
		
	}


	// 파일 전송 실시
	@GetMapping("/file/{gatherFileIdx}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@PathVariable int gatherFileIdx) throws IOException {

		// 파일 DTO 획득
		GatherFileDto gatherFileDto = gatherFileDao.getNo(gatherFileIdx);

		// 전송할 파일의 데이터 준비
		byte[] data = gatherFileDao.load(gatherFileIdx);
		ByteArrayResource resource = new ByteArrayResource(data);

		// 보낼 파일명 설정
		String encodeName = URLEncoder.encode(gatherFileDto.getGatherFileUserName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		// 실제 파일 전송
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				// .header("Content-Length",
				// String.valueOf(memberProfileDto.getMemberProfileSize()))
				.contentLength(gatherFileDto.getGatherFileSize()).body(resource);

	}

}