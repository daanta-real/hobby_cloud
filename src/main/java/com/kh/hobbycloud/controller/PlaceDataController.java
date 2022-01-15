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

import com.kh.hobbycloud.repository.place.PlaceFileDao;
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
	@Autowired
	private PlaceFileDao placeFileDao;
	
	// 변수준비: 서버 주소 관련
	@Autowired private String SERVER_ROOT;   // 환경변수로 설정한 사용자 루트 주소
	@Autowired private String SERVER_PORT;   // 환경변수로 설정한 사용자 포트 번호
	@Autowired private String CONTEXT_NAME; // 환경변수로 설정한 사용자 콘텍스트명
	
	@ResponseBody
	@PostMapping("/register")
	public String register(@ModelAttribute PlaceFileVO placeFileVO, HttpSession session) throws IllegalStateException, IOException {

		Integer memberIdx = (Integer) session.getAttribute("memberIdx");
		log.debug("ㅡㅡㅡ /placeData/register (장소 파일 등록 AJAX POST) memberIdx : ------>" +memberIdx);
		placeFileVO.setMemberIdx(memberIdx);
		log.debug("ㅡㅡㅡ 등록내용: {}", placeFileVO.getMemberIdx());

		int placeIdx = placeService.save(placeFileVO);
		return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + placeIdx;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public String update(@ModelAttribute PlaceEditVO placeEditVO) {
		try {
			log.debug("ㅡㅡㅡ /placeData/update (장소 파일 수정 AJAX POST) 진입");
			Integer placeIdx = placeEditVO.getPlaceIdx();
			log.debug("ㅡㅡㅡ /placeData/register (장소 파일 수정 AJAX POST) placeIdx" +placeIdx);
			log.debug("ㅡㅡㅡ 강의장 수정  {}", placeEditVO.toString());
			log.debug("ㅡㅡㅡ 수정내용: {}", placeEditVO);			

			placeService.update(placeEditVO); 
			
			log.debug("==================== 수정이 끝났습니다. 상세보기로 돌아갑니다.", placeEditVO);

			return SERVER_ROOT + ":" + SERVER_PORT + "/" + CONTEXT_NAME + "/place/detail/" + placeIdx;
			
		} catch(Exception e) {
			return "failed"; 
		}
		
	}
	
	//파일삭제
	@DeleteMapping("/fileDelete")
	public boolean fileDelete(@RequestParam int placeFileIdx) {
		return placeFileDao.deleteAjax(placeFileIdx);
	}

}
