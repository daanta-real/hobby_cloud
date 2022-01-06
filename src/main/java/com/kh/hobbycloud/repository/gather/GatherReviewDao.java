package com.kh.hobbycloud.repository.gather;

import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherReviewDto;
import com.kh.hobbycloud.vo.gather.GatherReviewVO;

public interface GatherReviewDao {

	//평점입력
	void insert(GatherReviewDto gatherReviewDto);
	//평점조회
	List<GatherReviewVO> list(int gatherIdx);
	//평점삭제
	boolean delete(int gatherReviewIdx);
	//평점수정
	void edit(GatherReviewDto gatherReviewDto);
}
