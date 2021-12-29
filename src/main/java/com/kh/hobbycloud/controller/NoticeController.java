package com.kh.hobbycloud.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hobbycloud.repository.notice.NoticeDao;
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
	//공지게시판 목록조회
	@RequestMapping("/list")
    public String list(Model model) {
    	
    	model.addAttribute("list",noticeDao.list());
    	return "notice/list";
    }
	
	//게시판 상세조회
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeIdx, Model model) {
		model.addAttribute("noticeVO",noticeDao.get(noticeIdx));
		return "notice/detail";
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
		noticeService.insert(noticeVO);
		return "redirect:detail?noticeIdx="+noticeIdx;
		
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
	
	

}
