package com.kh.hobbycloud.repository.gather;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherReviewDto;
import com.kh.hobbycloud.vo.gather.GatherReviewVO;

@Repository
public class GatherReviewDaoImpl  implements GatherReviewDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(GatherReviewDto gatherReviewDto) {
		sqlSession.insert("gatherReview.insert",gatherReviewDto);
		
	}

	@Override
	public List<GatherReviewVO> list(int gatherIdx) {
		return sqlSession.selectList("gatherReview.list",gatherIdx);
	}

	@Override
	public boolean delete(int gatherReviewIdx) {
	
		int result = sqlSession.delete("gatherReview.delete", gatherReviewIdx);
		return result>0;
	}
}
