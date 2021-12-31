package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

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

import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.service.notice.NoticeService;
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
    public String list(Model model) {
    	
    	model.addAttribute("list",noticeDao.list());
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
	public String detail(@PathVariable int noticeIdx, Model model) {
		// 데이터 획득: VO 및 DTO
		        noticeDao.views(noticeIdx);
				NoticeVO noticeVO = noticeDao.get(noticeIdx);

				// 획득된 데이터를 Model에 지정
				List<NoticeFileDto> list = noticeFileDao.getIdx(noticeIdx);
				model.addAttribute("NoticeVO", noticeVO);
				model.addAttribute("list", list);

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
	public String write(@ModelAttribute NoticeVO noticeVO) throws IllegalStateException, IOException {
		log.debug("---------------------{}",noticeVO);
		int noticeIdx=noticeDao.getsequences();
		noticeVO.setNoticeIdx(noticeIdx);
		noticeVO.setMemberIdx(99996);
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
		return "redirect:detail?noticeIdx="+noticeIdx;
	}
	
	
	
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
