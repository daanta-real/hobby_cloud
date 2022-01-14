package com.kh.hobbycloud.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.service.place.PlaceService;
import com.kh.hobbycloud.vo.place.PlaceEditVO;
import com.kh.hobbycloud.vo.place.PlaceFileVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/placeData")
public class PlaceDataController {

	@Autowired
	private PlaceService placeService;
	
	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명
	
	@ResponseBody
	@PostMapping("/register")
	public String register(@ModelAttribute PlaceFileVO placeFileVO, HttpSession session) throws IllegalStateException, IOException {

			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) 진입");
			Integer memberIdx = (Integer) session.getAttribute("memberIdx");
			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) memberIdx" +memberIdx);
			placeFileVO.setMemberIdx(memberIdx);
			log.debug("ㅡㅡㅡ 등록내용: {}", placeFileVO.getMemberIdx());

			session.setAttribute("placeIdx", placeFileVO.getPlaceIdx());
			int placeIdx = placeService.save(placeFileVO);
			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) placeIdx" +placeIdx);
			log.debug("------------------------------------------");
			log.debug("-------------------------------"+SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + placeIdx);
			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + placeIdx;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute PlaceEditVO placeEditVO, HttpSession session) {
		try {
			log.debug("ㅡㅡㅡ /placeData/update (장소 파일 수정 AJAX POST) 진입");
			Integer memberIdx = (Integer) session.getAttribute("memberIdx");
			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) memberIdx" +memberIdx);
			placeEditVO.setMemberIdx(memberIdx);
			Integer placeIdx = placeEditVO.getPlaceIdx();
			log.debug("ㅡㅡㅡ 등록내용: {}", placeEditVO.getMemberIdx());
			log.debug("ㅡㅡㅡ 강의장 수정 memberIdx: {}", placeEditVO.toString());
			log.debug("ㅡㅡㅡ 수정내용: {}", placeEditVO);			

			placeService.update(placeEditVO); 
			
			log.debug("==================== 수정이 끝났습니다. 상세보기로 돌아갑니다.", placeEditVO);

			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + placeIdx;
			
		} catch(Exception e) {
			return "failed"; 
		}
		
	}

}
