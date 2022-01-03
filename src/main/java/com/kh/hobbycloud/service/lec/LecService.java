package com.kh.hobbycloud.service.lec;

import java.io.IOException;

import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
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
	void likeUpdate(LecLikeVO lecLikeVO);

	
	
}
