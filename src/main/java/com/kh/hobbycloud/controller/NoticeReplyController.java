package com.kh.hobbycloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.notice.NoticeReplyDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeReplyDao;
import com.kh.hobbycloud.vo.notice.NoticeReplyVO;
/*
@RestController
@RequestMapping("/noticeReply")
public class NoticeReplyController {
	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	NoticeReplyDao noticeReplyDao;
	
	//댓글작성
	@PostMapping("/insert")
	public void insert(@ModelAttribute NoticeReplyDto noticeReplyDto,HttpSession session) {
		//int noticeReplyIdx=noticeReplyDao.sequence();
		int memberIdx=(int)session.getAttribute("memberIdx");
		noticeReplyDto.setMemberIdx(memberIdx);
		noticeReplyDao.insert(noticeReplyDto);
	}
	
	//댓글목록
	@GetMapping("/list")
	public List<NoticeReplyVO>list(int noticeIdx){
		return noticeReplyDao.list(noticeIdx);
	}
	//댓글삭제
	@DeleteMapping("/delete")
	public void delete(@RequestParam int noticeReplyIdx) {
		noticeReplyDao.delete(noticeReplyIdx);
	}
	//댓글수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute NoticeReplyVO noticeReplyVO) {
		noticeReplyDao.edit(noticeReplyVO);
	}

}
*/
