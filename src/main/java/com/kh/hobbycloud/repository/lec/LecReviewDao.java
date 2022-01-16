package com.kh.hobbycloud.repository.lec;

import java.util.List;

import com.kh.hobbycloud.entity.lec.LecReviewDto;
import com.kh.hobbycloud.vo.lec.LecReviewVO;

public interface LecReviewDao {
	//평점입력
	void insert(LecReviewDto lecReviewDto);
	//평점조회
	List<LecReviewVO> list(int lecIdx);
	//평점삭제
	boolean delete(int lecReviewIdx);
	//평점수정
	void edit(LecReviewDto lecReviewDto);
	List<LecReviewVO> listBy(int startRow, int endRow, int lecIdx);
}
