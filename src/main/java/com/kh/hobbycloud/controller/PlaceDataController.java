package com.kh.hobbycloud.controller;

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
	@PostMapping("/save")
	public String register(@ModelAttribute PlaceFileVO PlaceFileVO, HttpSession session) {
		try {
			
			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) 진입");
			log.debug("ㅡㅡㅡ 등록내용: {}", PlaceFileVO);
			
			placeService.save(PlaceFileVO);
			
			log.debug("ㅡㅡㅡ 등록이 끝났습니다. AJAX를 종료합니다.");
			Integer idx = PlaceFileVO.getPlaceIdx();
			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + idx;
			
		} catch(Exception e) { return "failed"; }
		
	}
	
	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute PlaceEditVO placeEditVO) {
		try {
			
			log.debug("ㅡㅡㅡ /placeData/update (장소 파일 수정 AJAX POST) 진입");
			log.debug("ㅡㅡㅡ 수정내용: {}", placeEditVO);
			
			placeService.update(placeEditVO);
			
			log.debug("ㅡㅡㅡ 수정이 끝났습니다. AJAX를 종료합니다.");
			Integer idx = placeEditVO.getPlaceIdx();
			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + idx;
			
		} catch(Exception e) { return "failed"; }
		
	}

}
