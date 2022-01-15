package com.kh.hobbycloud.service.place;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceEditVO;
import com.kh.hobbycloud.vo.place.PlaceFileVO;
import com.kh.hobbycloud.vo.place.PlaceListVO;

public interface PlaceService {
	
	//등록
	int save(PlaceFileVO placeFileVO) throws IllegalStateException, IOException;
	
	//수정
	void update(PlaceEditVO placeEditVO) throws IllegalStateException, IOException;
	
	//장소 목록 조회
	List<PlaceListVO> list(PlaceCriteria cri);
	
	//장소 총 갯수
	int listCount();


}