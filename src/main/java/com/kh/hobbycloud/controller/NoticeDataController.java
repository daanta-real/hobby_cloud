package com.kh.hobbycloud.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.repository.notice.NoticeReplyDao;
import com.kh.hobbycloud.service.notice.NoticeService;
import com.kh.hobbycloud.vo.notice.NoticeEditVO;
import com.kh.hobbycloud.vo.notice.NoticeFileVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/noticeData")
public class NoticeDataController {
	@Autowired
	private NoticeDao noticeDao;
	@Autowired
	private NoticeReplyDao noticeReplyDao;
	
	@Autowired
	private NoticeFileDao noticeFileDao;
	
	@Autowired
	private NoticeService noticeService;
	
	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명
	
	//파일삭제
		@DeleteMapping("/fileDelete")
		public boolean fileDelete(@RequestParam int noticeFileIdx) {
			return noticeFileDao.deleteAjax(noticeFileIdx);
		}
		
		@ResponseBody
		@PostMapping("/write")
		public String insert(@ModelAttribute NoticeFileVO noticeFileVO,HttpSession session) throws IllegalStateException, IOException {
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶NoticeDataController.insert 실행");
			int memberIdx = (int) session.getAttribute("memberIdx");
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶noticeFileVO={}",noticeFileVO);
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶memberIdx={}",memberIdx);
			noticeFileVO.setMemberIdx(memberIdx);
			int noticeIdx = noticeService.save(noticeFileVO);
			System.out.println(noticeIdx);
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶noticeIdx={}",noticeIdx);
			return  SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/notice/detail/" + noticeIdx;
		}
		
		@ResponseBody
		@PostMapping("/update")
		public String update(@ModelAttribute NoticeEditVO noticeEditVO) {
			try { 
				Integer noticeIdx = noticeEditVO.getNoticeIdx();
				log.debug("==================== /lec/edit/{} (강좌 파일 수정 POST) 진입", noticeIdx);
				log.debug("==================== 수정내용: {}", noticeEditVO);
				noticeService.edit(noticeEditVO);
				log.debug("==================== 수정이 끝났습니다. 상세보기로 돌아갑니다.", noticeEditVO);
				return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/notice/detail/" + noticeIdx;
			} catch(Exception e) {
				return "failed"; 
			}
		}

}
