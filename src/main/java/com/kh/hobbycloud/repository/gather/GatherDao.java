 package com.kh.hobbycloud.repository.gather;


import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.CriteriaSearch;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;



public interface GatherDao {
	 List<GatherVO> listSearch(GatherSearchVO gatherSearchVO);
	 List<GatherVO> list();
	 void insert(GatherDto gatherDto);
	 GatherVO get(int gatherIdx);
	 int  getSequence();
	 void delete(int gatherIdx);
//	 List<GatherVO> getUpdate(int gatherIdx);
	 boolean update(GatherDto gatherDto);   
	 //List<GatherVO> listPage(int startRow, int endRow);
	
	 //게시글 목록 조회
	 List<GatherVO>list (Criteria cri);
	 //게시글 총개수
	 int listCount();
	  
	 //검색페이지 게시글 목록 조회
	 List<GatherVO>listBy(CriteriaSearch cri2);
	 //검색페이지 게시글 총개수
	 int listCountBy(GatherSearchVO gatherSearchVO);


}
