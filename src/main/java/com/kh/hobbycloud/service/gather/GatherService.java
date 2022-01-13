package com.kh.hobbycloud.service.gather;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.CriteriaSearch;
import com.kh.hobbycloud.vo.gather.GatherFileVO;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

public interface GatherService {
	int save(GatherFileVO gatherFileVO) throws IllegalStateException, IOException;
	void update(GatherFileVO gatherFileVO) throws IllegalStateException, IOException;
	
	//게시물 목록 조회
	List<GatherVO> list(Criteria cri);
	//게시물 총 갯수
	int listCount();
	//검색게시물 목록 조회
	List<GatherVO> listBy(CriteriaSearch cri2);
	//검색게시물 총 갯수
	int listCountBy(GatherSearchVO gatherSearchVO);
	
}
