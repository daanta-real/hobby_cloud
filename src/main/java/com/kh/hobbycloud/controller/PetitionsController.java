package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

import com.kh.hobbycloud.entity.petitions.PetitionsDto;
import com.kh.hobbycloud.entity.petitions.PetitionsFileDto;
import com.kh.hobbycloud.repository.petitions.PetitionsDao;
import com.kh.hobbycloud.repository.petitions.PetitionsFileDao;
import com.kh.hobbycloud.service.petitions.PetitionsService;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.PageMaker;
import com.kh.hobbycloud.vo.petitions.PetitionsVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/petitions")
public class PetitionsController {
	@Autowired
	private PetitionsDao petitionsDao;
	
	@Autowired
	private PetitionsService petitionsService;
	
	@Autowired
	private PetitionsFileDao petitionsFileDao;
	
	
	
	//청원게시판 목록조회
	@GetMapping("/list")
    public String list(Model model,Criteria cri) {
    	log.debug("ㅡㅡㅡ 청원게시판 목록조회 시작");
    	
    	List<PetitionsVO> petitionsVO = petitionsService.list(cri);
    	log.debug("게시판 목록을 갖고 옴. petitionsVO = {}", petitionsVO);
    	model.addAttribute("list", petitionsVO);
    	
    	PageMaker pageMaker = new PageMaker();
    	
    	pageMaker.setCri(cri);
    	int count = petitionsService.listCount();
    	log.debug("청원게시판 수: {}", count);
    	
    	pageMaker.setTotalCount(count);
    	log.debug("pageMaker 정보: {}", pageMaker);
    	model.addAttribute("pageMaker", pageMaker);
    	
    	log.debug("청워네시판으로 이동");
    	return "petitions/list";
    }
	//검색
	@PostMapping("/list")
	public String search(@RequestParam String column, @RequestParam String keyword, Model model) {
		model.addAttribute("list",petitionsDao.search(column, keyword));
		return "petitions/list";
	}
	
	//게시판 상세조회
	//@RequestMapping("/detail")
	//public String detail(@RequestParam int noticeIdx, Model model) {
	//	model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
	//	return "notice/detail";
	//}
	
	
	@RequestMapping("/detail/{petitionsIdx}")
	public String detail(@PathVariable int petitionsIdx, Model model, HttpSession session) {
		int count = 1;
		//데이터 획득: VO 및 DTO
	    petitionsDao.views(petitionsIdx);
		PetitionsDto petitionsDto = new PetitionsDto();
		petitionsDto.setPetitionsIdx(petitionsIdx);
		//System.out.println(count++);
		//boolean owner = boardDto.getBoardWriter().equals(memberId);
		
		//System.out.println("세션은 = "+session);
		//if(session != null) {
		//int memberIdx= (int)session.getAttribute("memberIdx");
		
		//System.out.println("회원idx="+memberIdx);
		//System.out.println(count++);
		//petitionsDto.setMemberIdx(memberIdx);
		//System.out.println(count++);
		//noticeDao.read(noticeDto);
		
		
		// 1. 조회한 글 번호 모음인 Set<Integer> NoticeViewedNo를 준비한다.
		// 1-1. noticeViewedNo 라는 이름의 저장소를 세션에서 꺼내어 본다.
		//Set<Integer> petitionsViewedNo = (Set<Integer>)session.getAttribute("petitionsViewedNo");
		//System.out.println(count++);
		// 1-2. boardViewedNo 가 null 이면 "처음 글을 읽는 상태"임을 말하므로 저장소를 신규로 생성
		//if(petitionsViewedNo == null){
		//	petitionsViewedNo = new HashSet<>();
			//System.out.println("처음으로 글을 읽기 시작했습니다(저장소 생성)");
		//}
		

		// 2. 본격적으로 상세 글정보를 얻어온다.
		
		PetitionsVO petitionsVO = petitionsDao.get(petitionsIdx);//단일조회
		
		System.out.println(count++);
		// 획득된 데이터를 Model에 지정
		List<PetitionsFileDto> list = petitionsFileDao.getIdx(petitionsIdx);
		System.out.println(count++);
		model.addAttribute("PetitionsVO", petitionsVO);
		System.out.println(count++);
		model.addAttribute("list", list);
		System.out.println(count++);
		
		
		
		// 3. 현재 글 번호를 저장소에 추가해본다
		// 3-1. 추가가 된다면 이 글은 처음 읽는 글
		// 3-2. 추가가 안된다면 이 글은 두 번 이상 읽은 글
		//if(memberIdx != petitionsVO.getMemberIdx() && petitionsViewedNo.add(petitionsIdx)){//처음 읽은 글인 경우
		//	petitionsDao.read(petitionsDto);//조회수 증가(남에 글일때만)
		//	//System.out.println("이 글은 처음 읽는 글입니다");
		//}
		//else{
			//System.out.println("이 글은 읽은 적이 있습니다");
		//}
		
		//System.out.println("저장소 : "+noticeViewedNo);
		
		//3. 갱신된 조회한 글 번호 모음을 다시 세션에 저장한다.
		//session.setAttribute("petitionsViewedNo", petitionsViewedNo);
		//System.out.println(count++);
		//}
		//else {
		//	PetitionsVO petitionsVO = petitionsDao.get(petitionsIdx);//단일조회
			
		//	System.out.println(count++);
			// 획득된 데이터를 Model에 지정
			//List<PetitionsFileDto> list = petitionsFileDao.getIdx(petitionsIdx);
			//System.out.println(count++);
			//model.addAttribute("PetitionsVO", petitionsVO);
			//System.out.println(count++);
			//model.addAttribute("list", list);
			//System.out.println(count++);
		//}
		
	
	
		
		

		// 페이지 리다이렉트 처리
		return "petitions/detail"; 
		
		
	
		//model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
		//return "notice/detail";
	}
	
	//게시글 작성
	@GetMapping("/write")
    public String write() {
    	return "petitions/write";
    }
	//글작성
//	@PostMapping("/write")
//	public String write(@ModelAttribute NoticeDto noticeDto) {
//		int noticeIdx=noticeDao.getsequences();
//		noticeDto.setNoticeIdx(noticeIdx);
//		noticeDto.setMemberIdx(99996);
//		noticeDao.insert(noticeDto);
//		return "redirect:detail?noticeIdx="+noticeIdx;
//		
//	}
	@PostMapping("/write")
	public String write(@ModelAttribute PetitionsVO petitionsVO,HttpSession session) throws IllegalStateException, IOException {
		log.debug("---------------------{}",petitionsVO);
		System.out.println(petitionsVO.getPetitionsDetail());
		System.out.println("제목목목"+petitionsVO.getPetitionsName());
		int petitionsIdx=petitionsDao.getsequences();
		int memberIdx=(int)session.getAttribute("memberIdx");
		petitionsVO.setPetitionsIdx(petitionsIdx);
		petitionsVO.setMemberIdx(memberIdx);
		//noticeVO.setMemberIdx(99996);
		petitionsService.save(petitionsVO);
		return "redirect:detail/"+petitionsIdx;
		
	}
	//글삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int petitionsIdx) {
		petitionsDao.delete(petitionsIdx);
		
		return "redirect:list";
	}
	//글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int petitionsIdx, Model model) {
		model.addAttribute("petitionsVO",petitionsDao.get(petitionsIdx));
	    
	return "petitions/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute PetitionsVO petitionsVO ,@RequestParam int petitionsIdx) {
		petitionsVO.setPetitionsIdx(petitionsIdx);
		petitionsDao.edit(petitionsVO);
		return "redirect:detail?petitionsIdx="+petitionsIdx;
	}
	
	
	
	// 파일 전송 실시
		@GetMapping("/file/{petitionsFileIdx}")
		@ResponseBody
		public ResponseEntity<ByteArrayResource> file(@PathVariable int petitionsFileIdx) throws IOException {

			// 파일 DTO 획득
			PetitionsFileDto petitionsFileDto = petitionsFileDao.getNo(petitionsFileIdx);

			// 전송할 파일의 데이터 준비
			byte[] data = petitionsFileDao.load(petitionsFileIdx);
			ByteArrayResource resource = new ByteArrayResource(data);

			// 보낼 파일명 설정
			String encodeName = URLEncoder.encode(petitionsFileDto.getPetitionsFileMemberName(), "UTF-8");
			encodeName = encodeName.replace("+", "%20");

			// 실제 파일 전송
			return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				// .header("Content-Length",
				// String.valueOf(memberProfileDto.getMemberProfileSize()))
				.contentLength(petitionsFileDto.getPetitionsFileSize()).body(resource);

		}

}
