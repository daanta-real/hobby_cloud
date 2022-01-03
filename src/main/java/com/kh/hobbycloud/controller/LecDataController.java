package com.kh.hobbycloud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecReplyDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/lecData")
public class LecDataController {
	
	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecReplyDao lecReplyDao;
	
	@Autowired
	private LecService lecService;
	
	
//	@GetMapping("/detail")
//	public String replyList(@RequestParam int lecIdx, Model model) {
//		List<LecReplyVO> list = lecReplyDao.replyList(lecIdx);
//		model.addAttribute("replyList", list);
//		return "lec/detail?lecIdx="+lecIdx;
//	}
	
	//댓글 리스트
	@GetMapping("/replyList")
	public List<LecReplyVO> replyList(@RequestParam int lecIdx){
		List<LecReplyVO> list = lecReplyDao.replyList(lecIdx);
		return list;
	}

	//모댓글 작성
	@PostMapping("/replyWrite")
	public LecDto replyWrite(@RequestParam LecReplyVO lecReplyVO, HttpSession session) {
		lecReplyVO.setMemberIdx((Integer)(session.getAttribute("memberIdx")));
		LecDto lecDto = lecReplyDao.lecWriteReply(lecReplyVO);
		return lecDto;
	}
	
	//답글 작성
	@PostMapping("/rereplyWrite")
	public LecDto rereplyWrite(@RequestParam LecReplyVO lecReplyVO, HttpSession session) {
//		lecReplyVO.setMemberNick((String)session.getAttribute("memberNick"));
		lecReplyVO.setMemberIdx((Integer)(session.getAttribute("memberIdx")));
		LecDto lecDto = lecReplyDao.lecWriteReReply(lecReplyVO);
		return lecDto;
	}
	
	//모댓글 삭제
	@RequestMapping("/replyDelete")
	public LecDto lecReplyDelete(@RequestParam LecReplyVO lecReplyVO) {
		LecDto lecDto = lecReplyDao.lecDeleteReply(lecReplyVO);
		return lecDto;
	}
	
	//답글 삭제
	@RequestMapping("/rereplyDelete")
	public LecDto rereplyWrite(@RequestParam LecReplyVO lecReplyVO) {
		LecDto lecDto = lecReplyDao.lecDeleteReReply(lecReplyVO);
		return lecDto;
	}
	
//   @RequestMapping("/selectBBScmt")
//	public List<Map<String,Object>> selectBBScmt(@RequestParam Map<String,Object> commandMap){
//	    logger.info("request: /selectBBScmt");
//	    List<Map<String,Object>> resultMap = null;
//	    int totalCmt = 0;
//	    try {
//	        int bbsidx = Integer.parseInt(commandMap.get("bbscmtidx").toString());
//	        
//	        resultMap = service.selectBBScmt(commandMap);
//	        totalCmt = service.getTotalCmt(bbsidx);//전체 댓글 개수
//	        resultMap.get(0).put("totalCmt", totalCmt);
//	    } catch (Exception e) {
//	        logger.debug(e.getMessage());
//	    }
//	    return resultMap;
//	}

	//좋아요
	@PostMapping("/likeUpdate")
	public Map<String,String> likeUpdate(@RequestBody LecLikeVO lecLikeVO){
		log.info("likeUpdate");
		
		Map<String,String> map = new HashMap<String, String>();
		
		try {
			lecService.likeUpdate(lecLikeVO);
			map.put("result", "success");
			
		}catch(Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		
		return map;
	}
}
