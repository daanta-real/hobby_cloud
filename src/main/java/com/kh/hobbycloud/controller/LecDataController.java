package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecReviewDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecReplyDao;
import com.kh.hobbycloud.repository.lec.LecReviewDao;
import com.kh.hobbycloud.repository.tutor.TutorDao;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;
import com.kh.hobbycloud.vo.lec.LecReplyVO;
import com.kh.hobbycloud.vo.lec.LecReviewVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/lecData")
public class LecDataController {

	@Autowired
	private LecReplyDao lecReplyDao;
	
	@Autowired
	private TutorDao tutorDao;
	
	@Autowired
	private LecService lecService;
	
	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecReviewDao lecReviewDao;

	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명

	@ResponseBody
	@PostMapping("/register")
	public String register(@ModelAttribute LecRegisterVO lecRegisterVO, HttpSession session)
			throws IllegalStateException, IOException {
		log.debug("================등록(placeIdx={}),ㄱㄱㄱㄱㄱ : {}", lecRegisterVO.getPlaceIdx(), lecRegisterVO);
		int tutorIdx = tutorDao.getTutorIdx((int)session.getAttribute("memberIdx"));
		lecRegisterVO.setTutorIdx(tutorIdx);
		int lecIdx = lecService.register(lecRegisterVO);
		return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/lec/detail/" + lecIdx;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute LecEditVO lecEditVO) {
		try {
			Integer idx = lecEditVO.getLecIdx();
			log.debug("==================== /lec/edit/{} (강좌 파일 수정 POST) 진입", idx);
			log.debug("==================== 수정내용: {}", lecEditVO);
			lecService.edit(lecEditVO);
			log.debug("==================== 수정이 끝났습니다. 상세보기로 돌아갑니다.", lecEditVO);
			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/lec/detail/" + idx;
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
	
	//평점입력
	@PostMapping("/reviewInsert")
	public void reviewInsert(@ModelAttribute LecReviewDto lecReviewDto,HttpSession session) {
	
		int memberIdx = (int)session.getAttribute("memberIdx");
		lecReviewDto.setMemberIdx(memberIdx);
		System.out.println(lecReviewDto);
		
		lecReviewDao.insert(lecReviewDto);
	}
	//평점목록
	@GetMapping("/reviewList")
	public List<LecReviewVO> list(
			@RequestParam(required = false, defaultValue = "1") int pageR,
			@RequestParam(required = false, defaultValue = "10") int sizeR,
			@RequestParam int lecIdx){
		int endRow = pageR * sizeR;
		int startRow = endRow - (sizeR - 1);
		return lecReviewDao.listBy(startRow, endRow, lecIdx);
	}
	//평점삭제
	@DeleteMapping("/reviewDelete")
	public boolean reviewDelete(@RequestParam int lecReviewIdx) {
		System.out.println("확인");
		System.out.println(lecReviewIdx);
		return lecReviewDao.delete(lecReviewIdx);
	}
	//평점수정
	@PostMapping("/reviewEdit")
	public void reviewEdit(@ModelAttribute LecReviewDto lecReviewDto) {	
		System.out.println("수정+" + lecReviewDto);
		lecReviewDao.edit(lecReviewDto);
	}
}
