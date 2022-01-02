package com.kh.hobbycloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecReplyDao;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

@RestController
@RequestMapping("/lecData")
public class LecDataController {
	
	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecReplyDao lecReplyDao;
	
	
//	@GetMapping("/detail")
//	public String replyList(@RequestParam int lecIdx, Model model) {
//		List<LecReplyVO> list = lecReplyDao.replyList(lecIdx);
//		model.addAttribute("replyList", list);
//		return "lec/detail?lecIdx="+lecIdx;
//	}
	
	//댓글 리스트
	@GetMapping("/replyList")
	@ResponseBody
	public List<LecReplyVO> replyList(@RequestParam int lecIdx){
		List<LecReplyVO> list = lecReplyDao.replyList(lecIdx);
		return list;
	}

	//모댓글 작성
	@PostMapping("/replyWrite")
	@ResponseBody
	public LecDto replyWrite(@RequestParam LecReplyVO lecReplyVO, HttpSession session) {
		lecReplyVO.setMemberIdx((Integer)(session.getAttribute("memberIdx")));
		LecDto lecDto = lecReplyDao.lecWriteReply(lecReplyVO);
		return lecDto;
	}
	
	//답글 작성
	@PostMapping("/rereplyWrite")
	@ResponseBody
	public LecDto rereplyWrite(@RequestParam LecReplyVO lecReplyVO, HttpSession session) {
//		lecReplyVO.setMemberNick((String)session.getAttribute("memberNick"));
		lecReplyVO.setMemberIdx((Integer)(session.getAttribute("memberIdx")));
		LecDto lecDto = lecReplyDao.lecWriteReReply(lecReplyVO);
		return lecDto;
	}
	
	//모댓글 삭제
	@RequestMapping("/replyDelete")
	@ResponseBody
	public LecDto lecReplyDelete(@RequestParam LecReplyVO lecReplyVO) {
		LecDto lecDto = lecReplyDao.lecDeleteReply(lecReplyVO);
		return lecDto;
	}
	
	//답글 삭제
	@RequestMapping("/rereplyDelete")
	@ResponseBody
	public LecDto rereplyWrite(@RequestParam LecReplyVO lecReplyVO) {
		LecDto lecDto = lecReplyDao.lecDeleteReReply(lecReplyVO);
		return lecDto;
	}
}
