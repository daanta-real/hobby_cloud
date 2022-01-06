package com.kh.hobbycloud.service.lec;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

public interface LecService {

	//등록
	int register(LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException;

	//수정
	void edit(LecEditVO lecEditVO) throws IllegalStateException, IOException;
	
	//좋아요
	int likeCount(LecLikeVO lecLikeVO);
	void likeInsert(LecLikeVO lecLikeVO);
	int likeGetInfo(LecLikeVO lecLikeVO);
	int likeUpdate(LecLikeVO lecLikeVO);
	
	//비회원일때
	int likeCountEvery(int lecIdx);

	//게시물 목록 조회
	List<LecListVO> list(LecCriteria cri);
	//게시물 총 갯수
	int listCount();
	
	
	
}
