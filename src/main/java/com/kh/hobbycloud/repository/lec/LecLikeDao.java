package com.kh.hobbycloud.repository.lec;

import com.kh.hobbycloud.vo.lec.LecLikeVO;

public interface LecLikeDao {

	int likeCount(LecLikeVO lecLikeVO);

	int likeGetInfo(LecLikeVO lecLikeVO);

	void likeInsert(LecLikeVO lecLikeVO);

	int likeUpdate(LecLikeVO lecLikeVO);

	int likeCountEvery(int lecIdx);
	
}
