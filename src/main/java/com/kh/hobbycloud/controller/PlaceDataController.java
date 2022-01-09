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

	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute PlaceEditVO placeEditVO) {
		try {
			Integer idx = placeEditVO.getPlaceIdx();
			log.debug("ㅡㅡㅡ /lec/edit/{} (장소 파일 수정 POST) 진입", idx);
			log.debug("ㅡㅡㅡ 수정내용: {}", placeEditVO);
			placeService.update(placeEditVO);
			log.debug("ㅡㅡㅡ 수정이 끝났습니다. 상세보기로 돌아갑니다.", placeEditVO);
			return "success";
		} catch(Exception e) {
			return "failed";
		}
	}

}
