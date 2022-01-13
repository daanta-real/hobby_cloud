package com.kh.hobbycloud.service.petitions;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.notice.NoticeVO;
import com.kh.hobbycloud.vo.petitions.PetitionsVO;

public interface PetitionsService {
	void save(PetitionsVO petitionsVO)throws IllegalStateException, IOException;
	
	//게시물 목록 조회
		List<PetitionsVO> list(Criteria cri);
		//게시물 총 갯수
		int listCount();

}
