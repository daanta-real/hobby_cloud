package com.kh.hobbycloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hobbycloud.service.place.PlaceService;
import com.kh.hobbycloud.vo.place.PlaceEditVO;

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
	@PostMapping("/update")
	public String update(@ModelAttribute PlaceEditVO placeEditVO) {
		try {
			Integer idx = placeEditVO.getPlaceIdx();
			log.debug("ㅡㅡㅡ /lec/edit/{} (장소 파일 수정 POST) 진입", idx);
			log.debug("ㅡㅡㅡ 수정내용: {}", placeEditVO);
			placeService.update(placeEditVO);
			log.debug("ㅡㅡㅡ 수정이 끝났습니다. 상세보기로 돌아갑니다.", placeEditVO);
			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/lec/detail/" + idx;
		} catch(Exception e) {
			return "failed";
		}
	}

}
