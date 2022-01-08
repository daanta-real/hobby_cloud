package com.kh.hobbycloud.repository.place;

import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceListVO;

public interface PlaceDao {
	//Place 삭제
	void delete(int gatherIdx);
	//Place idx
	int getSequence();
	//Place 등록
	void insert(PlaceDto placeDto);
	//Place 단일조회
	PlaceListVO get(int placeIdx);
	//Place 목록 조회
	List<PlaceListVO> list(PlaceCriteria cri);
	//Place 수정
	boolean update(PlaceDto placeDto);	
	//Place 총개수
	int listCount();
	//Place 검색
	List<PlaceListVO> listSearch(Map<String, Object> param);
	//Place 페이지
	List<PlaceListVO> listPage(int startRow, int endRow);
}

