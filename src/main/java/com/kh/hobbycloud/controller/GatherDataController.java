package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.entity.gather.GatherReplyDto;
import com.kh.hobbycloud.entity.gather.GatherReviewDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.repository.gather.GatherHeadsDao;
import com.kh.hobbycloud.repository.gather.GatherReplyDao;
import com.kh.hobbycloud.repository.gather.GatherReviewDao;
import com.kh.hobbycloud.service.gather.GatherService;
import com.kh.hobbycloud.vo.gather.GatherChartVO;
import com.kh.hobbycloud.vo.gather.GatherFileVO;
import com.kh.hobbycloud.vo.gather.GatherReplyVO;
import com.kh.hobbycloud.vo.gather.GatherReviewVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/gatherData")
public class GatherDataController {

	@Autowired
	private GatherDao gatherDao;
	@Autowired
	private GatherReplyDao gatherReplyDao;
	@Autowired
	private GatherReviewDao gatherReviewDao;

	@Autowired
	private GatherFileDao gatherFileDao;
	@Autowired
	private GatherHeadsDao gatherHeadsDao;
	@Autowired
	private GatherService gatherService;
	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명

	//ajax연습용
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

	public void replyInsert(@ModelAttribute GatherReplyDto gatherReplyDto,HttpSession session) {
		int memberIdx =(int) session.getAttribute("memberIdx");
		gatherReplyDto.setMemberIdx(memberIdx);
		gatherReplyDao.insert(gatherReplyDto);
	}
	//게시판 댓글목록(페이지네이션)
	@GetMapping("/replyList")
	public List<GatherReplyVO> replyList(
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "10") int size,
			@RequestParam int gatherIdx)	{

		int endRow = page * size;
		int startRow = endRow - (size - 1);
		return gatherReplyDao.listBy(startRow, endRow, gatherIdx);
	}

	//댓글 삭제
	@DeleteMapping("/replyDelete")
	public boolean replyDelete(@RequestParam int gatherReplyIdx) {
	return gatherReplyDao.delete(gatherReplyIdx);
	}

	//댓글 수정
	@PostMapping("/replyEdit")
	public void replyEdit(@ModelAttribute  GatherReplyDto gatherReplyDto) {
		gatherReplyDao.edit(gatherReplyDto);
	}
	//파일삭제
	@DeleteMapping("/fileDelete")
	public boolean fileDelete(@RequestParam int gatherFileIdx) {
		return gatherFileDao.deleteAjax(gatherFileIdx);
	}
	//평점입력
	@PostMapping("/reviewInsert")
	public void reviewInsert(@ModelAttribute GatherReviewDto gatherReviewDto,HttpSession session) {

		int memberIdx =(int) session.getAttribute("memberIdx");
		gatherReviewDto.setMemberIdx(memberIdx);
		System.out.println(gatherReviewDto);

		gatherReviewDao.insert(gatherReviewDto);
	}
	//평점목록(페이지네이션 포함)
	@GetMapping("/reviewList")
	public List<GatherReviewVO> list(
			@RequestParam(required = false, defaultValue = "1") int pageR,
			@RequestParam(required = false, defaultValue = "10") int sizeR,
			@RequestParam int gatherIdx){
		int endRow = pageR * sizeR;
		int startRow = endRow - (sizeR - 1);
		return gatherReviewDao.listBy(startRow, endRow, gatherIdx);
	}
	//평점삭제
	@DeleteMapping("/reviewDelete")
	public boolean reviewDelete(@RequestParam int gatherReviewIdx) {
		System.out.println("확인");
		System.out.println(gatherReviewIdx);
		return gatherReviewDao.delete(gatherReviewIdx);
	}
	//평점수정
	@PostMapping("/reviewEdit")
	public void reviewEdit(@ModelAttribute GatherReviewDto gatherReviewDto) {
		System.out.println("수정+"+gatherReviewDto);
		gatherReviewDao.edit(gatherReviewDto);
	}
	//성별 별 인원수 구하기
	@GetMapping("/genderCount")
	public List<GatherChartVO> countByGender(@RequestParam int gatherIdx){
		System.out.println(gatherIdx);
		System.out.println("왓ㅅ음");
		return gatherHeadsDao.countByGender(gatherIdx);
	}
	@ResponseBody
	@PostMapping("/insert")
	public String insert(@ModelAttribute GatherFileVO gatherFileVO,HttpSession session) throws IllegalStateException, IOException {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶GatherDataController.insert 실행");
		int memberIdx = (int) session.getAttribute("memberIdx");
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶gatherFileVO={}",gatherFileVO);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶memberIdx={}",memberIdx);
		gatherFileVO.setMemberIdx(memberIdx);
		int gatherIdx = gatherService.save(gatherFileVO);
		System.out.println(gatherIdx);
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶gatherIdx={}",gatherIdx);
		return  SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/gather/detail/" + gatherIdx;
	}
}
