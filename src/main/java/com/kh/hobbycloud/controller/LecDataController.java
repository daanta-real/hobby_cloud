package com.kh.hobbycloud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecReplyDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/lecData")
public class LecDataController {

	@Autowired
	private LecReplyDao lecReplyDao;

	@Autowired
	private LecService lecService;
	
	@Autowired
	private LecDao lecDao;

	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute LecEditVO lecEditVO) {
		try {
			Integer idx = lecEditVO.getLecIdx();
			log.debug("ㅡㅡㅡ /lec/edit/{} (강좌 파일 수정 POST) 진입", idx);
			log.debug("ㅡㅡㅡ 수정내용: {}", lecEditVO);
			lecService.edit(lecEditVO);
			log.debug("ㅡㅡㅡ 수정이 끝났습니다. 상세보기로 돌아갑니다.", lecEditVO);
			return "success";
		} catch(Exception e) {
			return "failed";
		}
	}

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
	public Map<String, Object> likeUpdate(@RequestBody LecLikeVO lecLikeVO, HttpSession session){
		log.info("likeUpdate");

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			lecLikeVO.setMemberIdx((Integer)session.getAttribute("memberIdx"));
			lecService.likeUpdate(lecLikeVO);
			int like = lecLikeVO.getAllIsLike();
			map.put("result", "success");
			map.put("like", like);
		}catch(Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}

		return map;
	}
	
	//모달창에 쓸 목록 조회(임시용. 장소 만들어지면 대체해야함)
	@GetMapping("/lecList")
	public List<LecListVO> lecList(){
		return lecDao.list();
	}
}
