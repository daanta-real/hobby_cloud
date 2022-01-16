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

import com.kh.hobbycloud.entity.petitions.PetitionsReplyDto;
import com.kh.hobbycloud.repository.petitions.PetitionsDao;
import com.kh.hobbycloud.repository.petitions.PetitionsFileDao;
import com.kh.hobbycloud.repository.petitions.PetitionsReplyDao;
import com.kh.hobbycloud.service.petitions.PetitionsService;
import com.kh.hobbycloud.vo.petitions.PetitionsReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/petitionsData")
public class PetitionsDataController {

	@Autowired
	private PetitionsDao petitionsDao;
	@Autowired
	private PetitionsReplyDao petitionsReplyDao;

	@Autowired
	private PetitionsFileDao petitionsFileDao;

	@Autowired
	private PetitionsService petitionsrService;
	// 변수준비: 서버 주소 관련
	@Autowired
	private String SERVER_ROOT; // 환경변수로 설정한 사용자 루트 주소
	@Autowired
	private String SERVER_PORT; // 환경변수로 설정한 사용자 포트 번호
	@Autowired
	private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명
	
	//게시판 댓글 작성
		@PostMapping("/replyInsert")
		public void replyInsert(@ModelAttribute PetitionsReplyDto petitionsReplyDto,HttpSession session) {
			System.out.println("들어옴");
			int memberIdx =(int) session.getAttribute("memberIdx");
			petitionsReplyDto.setMemberIdx(memberIdx);
			petitionsReplyDao.insert(petitionsReplyDto);
			log.debug("------------------------------{}",petitionsReplyDto);
		}
		//게시판 댓글목록(페이지네이션)
		@GetMapping("/replyList")
		public List<PetitionsReplyVO> replyList(
				@RequestParam(required = false, defaultValue = "1") int page,
				@RequestParam(required = false, defaultValue = "10") int size,
				@RequestParam int petitionsIdx)	{

			int endRow = page * size;
			int startRow = endRow - (size - 1);
			return petitionsReplyDao.listBy(startRow, endRow, petitionsIdx);
		}

		//댓글 삭제
		@DeleteMapping("/replyDelete")
		public boolean replyDelete(@RequestParam int petitionsReplyIdx) {
		return petitionsReplyDao.delete(petitionsReplyIdx);
		}

		//댓글 수정
		@PostMapping("/replyEdit")
		public void replyEdit(@ModelAttribute  PetitionsReplyDto petitionsReplyDto) {
			petitionsReplyDao.edit(petitionsReplyDto);
		}

}
