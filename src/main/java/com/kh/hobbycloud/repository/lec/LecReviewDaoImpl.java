package com.kh.hobbycloud.repository.lec;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecReviewDto;
import com.kh.hobbycloud.vo.lec.LecReviewVO;

@Repository
public class LecReviewDaoImpl implements LecReviewDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(LecReviewDto lecReviewDto) {
		sqlSession.insert("lecReview.insert", lecReviewDto);
	}

	@Override
	public List<LecReviewVO> list(int lecIdx) {
		return sqlSession.selectList("lecReview.list", lecIdx);
	}

	@Override
	public boolean delete(int lecReviewIdx) {
		int result = sqlSession.delete("lecReview.delete", lecReviewIdx);
		return result > 0;
	}

	@Override
	public void edit(LecReviewDto lecReviewDto) {
		sqlSession.update("lecReview.edit", lecReviewDto);
	}
}
