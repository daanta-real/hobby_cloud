package com.kh.hobbycloud.repository.lec;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.vo.lec.LecLikeVO;

@Repository
public class LecLikeDaoImpl implements LecLikeDao {
	
	@Autowired
	private SqlSession sqlSession;
		
	@Override
	public int likeCount(LecLikeVO lecLikeVO) {
		return sqlSession.selectOne("lecLike.likeCount", lecLikeVO);
	}
	
	@Override
	public int likeGetInfo(LecLikeVO lecLikeVO) {
		return sqlSession.selectOne("lecLike.likeGetInfo", lecLikeVO);
	}
	
	@Override
	public void likeInsert(LecLikeVO lecLikeVO) {
		sqlSession.insert("lecLike.likeInsert", lecLikeVO);
	}
	
	@Override
	public int likeUpdate(LecLikeVO lecLikeVO) {
		sqlSession.update("lecLike.likeUpdate", lecLikeVO);
		return lecLikeVO.getAllIsLike();
	}
	
	@Override
	public int likeCountEvery(int lecIdx) {
		return sqlSession.selectOne("lecLike.likeCountEvery", lecIdx);
	}
}
