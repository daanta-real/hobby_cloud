package com.kh.hobbycloud.repository.place;

import java.util.List;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceListVO;
import com.kh.hobbycloud.vo.place.PlaceSearchVO;
import com.kh.hobbycloud.vo.place.PlaceVO;

public interface PlaceDao {
	//Place 삭제
	void delete(int gatherIdx);
	//Place idx
	int getSequence();
	//Place 등록
	void insert(PlaceDto placeDto);
	//Place 단일조회
	public PlaceVO get(int placeIdx);
	//Place 수정
	boolean update(PlaceDto placeDto);	
	//Place 목록 조회
	List<PlaceListVO> list(PlaceCriteria cri);
	//Place 총개수
	int listCount();
	//Place 검색
	List<PlaceListVO> listSearch(PlaceSearchVO placeSearchVO);
	//Place 페이지
	List<PlaceListVO> listPage(int startRow, int endRow);
	//Place Ajax 페이지네이션
	List<PlaceListVO> listBy(int startRow, int endRow);
}

