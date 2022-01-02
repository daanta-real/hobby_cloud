package com.kh.hobbycloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.gather.GatherReplyDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.repository.gather.GatherReplyDao;
import com.kh.hobbycloud.vo.gather.GatherReplyVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

@RestController
@RequestMapping("/gatherData")
public class GatherDataController {

	@Autowired
	private GatherDao gatherDao;
	@Autowired
	private GatherReplyDao gatherReplyDao;
	
	@Autowired
	private GatherFileDao gatherFileDao;
	@GetMapping("/hello")
	public String home() {
		return "home";
	}
	
	
	//소모임장소 목록조회
	@GetMapping("/gatherList")
	public List<GatherVO> gatherList(){
		return gatherDao.list();
	}
	//게시판 댓글 작성
	@PostMapping("/replyInsert")
	public void replyInsert(@ModelAttribute GatherReplyDto gatherReplyDto) {
		System.out.println("젬ㄴ으ㅐ라ㅡㅁㅇ내ㅑ러ㅜㅇㄴ먀ㅕㅐ로ㅓㅜㅁㅇ냐ㅕㅛㅗㅠㅕㅛㅁㄹㄴ으");
		System.out.println(gatherReplyDto);
		gatherReplyDao.insert(gatherReplyDto);
	}
	//게시판 댓글목록
	@GetMapping("/replyList")
	public List<GatherReplyVO> replyList(int gatherIdx) {
		return gatherReplyDao.list(gatherIdx);
	}
	
	@DeleteMapping("/replyDelete")
	public boolean replyDelete(@RequestParam int gatherReplyIdx) {
	return gatherReplyDao.delete(gatherReplyIdx);
	}
	
	@DeleteMapping("/fileDelete")
	public boolean fileDelete(@RequestParam int gatherFileIdx) {
		return gatherFileDao.deleteAjax(gatherFileIdx);
	}
}
