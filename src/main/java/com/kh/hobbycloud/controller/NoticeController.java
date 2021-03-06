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
import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.service.notice.NoticeService;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.GatherVO;
import com.kh.hobbycloud.vo.gather.PageMaker;
import com.kh.hobbycloud.vo.notice.NoticeVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private NoticeFileDao noticeFileDao;
	
	
	
	
	
	//공지게시판 목록조회
	@GetMapping("/list")
    public String list(Model model,Criteria cri) {
    	
    	model.addAttribute("list",noticeService.list(cri));
    	
    	PageMaker pageMaker = new PageMaker();
    	pageMaker.setCri(cri);
    	pageMaker.setTotalCount(noticeService.listCount());
    	model.addAttribute("pageMaker",pageMaker);
    	
    	return "notice/list";
    }
	//검색
	@PostMapping("/list")
	public String search(@RequestParam String column, @RequestParam String keyword, Model model) {
		model.addAttribute("list",noticeDao.search(column, keyword));
		return "notice/list";
	}
	
	//게시판 상세조회
	//@RequestMapping("/detail")
	//public String detail(@RequestParam int noticeIdx, Model model) {
	//	model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
	//	return "notice/detail";
	//}
	
	
	@RequestMapping("/detail/{noticeIdx}")
	public String detail(@PathVariable int noticeIdx, Model model, HttpSession session) {
		//int count = 1;
		//데이터 획득: VO 및 DTO
		noticeDao.views(noticeIdx);
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeIdx(noticeIdx);
		//System.out.println(count++);
		//boolean owner = boardDto.getBoardWriter().equals(memberId);
		
		//System.out.println("세션은 = "+session);
		//if(session != null) {
		//int memberIdx= (int)session.getAttribute("memberIdx");
		
		//System.out.println("회원idx="+memberIdx);
		//System.out.println(count++);
		//noticeDto.setMemberIdx(memberIdx);
		//System.out.println(count++);
		//noticeDao.read(noticeDto);
		
		
		// 1. 조회한 글 번호 모음인 Set<Integer> NoticeViewedNo를 준비한다.
		// 1-1. noticeViewedNo 라는 이름의 저장소를 세션에서 꺼내어 본다.
		//Set<Integer> noticeViewedNo = (Set<Integer>)session.getAttribute("noticeViewedNo");
		//System.out.println(count++);
		// 1-2. boardViewedNo 가 null 이면 "처음 글을 읽는 상태"임을 말하므로 저장소를 신규로 생성
		//if(noticeViewedNo == null){
		//	noticeViewedNo = new HashSet<>();
			//System.out.println("처음으로 글을 읽기 시작했습니다(저장소 생성)");
		//}
		

		//2. 본격적으로 상세 글정보를 얻어온다.
		
		NoticeVO noticeVO = noticeDao.get(noticeIdx);//단일조회
		
		//System.out.println(count++);
		// 획득된 데이터를 Model에 지정
		List<NoticeFileDto> list = noticeFileDao.getIdx(noticeIdx);
		//System.out.println(count++);
		model.addAttribute("NoticeVO", noticeVO);
		//System.out.println(count++);
		model.addAttribute("list", list);
		//System.out.println(count++);
		
		
		
		// 3. 현재 글 번호를 저장소에 추가해본다
		// 3-1. 추가가 된다면 이 글은 처음 읽는 글
		// 3-2. 추가가 안된다면 이 글은 두 번 이상 읽은 글
		//if(memberIdx != noticeVO.getMemberIdx() && noticeViewedNo.add(noticeIdx)){//처음 읽은 글인 경우
		//	noticeDao.read(noticeDto);//조회수 증가(남에 글일때만)
			//System.out.println("이 글은 처음 읽는 글입니다");
		//}
		//else{
			//System.out.println("이 글은 읽은 적이 있습니다");
		//}
		
		//System.out.println("저장소 : "+noticeViewedNo);
		
		//3. 갱신된 조회한 글 번호 모음을 다시 세션에 저장한다.
		//session.setAttribute("noticeViewedNo", noticeViewedNo);
		//System.out.println(count++);
		//}
		//else {
			//NoticeVO noticeVO = noticeDao.get(noticeIdx);//단일조회
		//	System.out.println(count++);
			// 획득된 데이터를 Model에 지정
			//List<NoticeFileDto> list = noticeFileDao.getIdx(noticeIdx);
		//	System.out.println(count++);
			//model.addAttribute("NoticeVO", noticeVO);
			//System.out.println(count++);
			//model.addAttribute("list", list);
			//System.out.println(count++);
		//}
		
	
	
		
		

		// 페이지 리다이렉트 처리
		return "notice/detail"; 
		
		
	
		//model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
		//return "notice/detail";
	}
	
	//게시글 작성
	@GetMapping("/write")
    public String write() {
    	return "notice/write";
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
	  public String write(@ModelAttribute NoticeVO noticeVO,HttpSession session) throws IllegalStateException, IOException {
	  log.debug("---------------------{}",noticeVO);
	  int noticeIdx=noticeDao.getsequences();
	  int memberIdx=(int)session.getAttribute("memberIdx");
	  noticeVO.setNoticeIdx(noticeIdx);
	  noticeVO.setMemberIdx(memberIdx);
	  //noticeVO.setMemberIdx(99996);
	  noticeService.save(noticeVO);
	  
	  return "redirect:detail/"+noticeIdx;
	  
	  }
	 
	//글삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int noticeIdx) {
		noticeDao.delete(noticeIdx);
		
		return "redirect:list";
	}
	//글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeIdx, Model model) {
		model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
	    
	return "notice/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeVO noticeVO ,@RequestParam int noticeIdx) {
		noticeVO.setNoticeIdx(noticeIdx);
		noticeDao.edit(noticeVO);
		
		
		return "redirect:detail/"+noticeIdx;
	}
	//글수정 (파일)
	// 글 수정 폼 페이지/update/123
//		@GetMapping("/edit/{noticeIdx}")
//		public String update(@PathVariable int noticeIdx, Model model) {
//			// 데이터 획득: VO 및 DTO
//			NoticeVO noticeVO = noticeDao.get(noticeIdx);
//
//			// 획득된 데이터를 Model에 지정
//			List<NoticeFileDto> list = noticeFileDao.getIdx(noticeIdx);
//			model.addAttribute("NoticeVO", noticeVO);
//			model.addAttribute("list", list);
//			
//			List<NoticeFileDto> fileList = noticeFileDao.getIdx(noticeIdx);
//	
//			model.addAttribute("fileList", fileList); 
//
//			return "notice/edit";
//		}
		
		//글 수정 실시
		//@PostMapping("/edit/{noticeIdx}")
		//public String update2(@ModelAttribute NoticeVO noticeVO,HttpSession session) throws IllegalStateException, IOException {

			// 수정
			//int memberIdx = (int)session.getAttribute("memberIdx");
			//noticeVO.setMemberIdx(memberIdx);
			//noticeService.edit(noticeVO);	
			//noticeDao.edit(noticeVO);
			//System.out.println("수정"+noticeVO);
			//int noticeIdx = noticeVO.getNoticeIdx();
			//return "redirect:/notice/detail/" + noticeIdx;
			
		//}
		
	
	
	
	// 파일 전송 실시
		@GetMapping("/file/{noticeFileIdx}")
		@ResponseBody
		public ResponseEntity<ByteArrayResource> file(@PathVariable int noticeFileIdx) throws IOException {

			// 파일 DTO 획득
			NoticeFileDto noticeFileDto = noticeFileDao.getNo(noticeFileIdx);

			// 전송할 파일의 데이터 준비
			byte[] data = noticeFileDao.load(noticeFileIdx);
			ByteArrayResource resource = new ByteArrayResource(data);

			// 보낼 파일명 설정
			String encodeName = URLEncoder.encode(noticeFileDto.getNoticeFileMemberName(), "UTF-8");
			encodeName = encodeName.replace("+", "%20");

			// 실제 파일 전송
			return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				// .header("Content-Length",
				// String.valueOf(memberProfileDto.getMemberProfileSize()))
				.contentLength(noticeFileDto.getNoticeFileSize()).body(resource);

		}
	
	
	

}
