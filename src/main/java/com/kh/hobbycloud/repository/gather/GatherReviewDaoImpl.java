package com.kh.hobbycloud.repository.gather;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public void edit(GatherReviewDto gatherReviewDto) {
		sqlSession.update("gatherReview.edit",gatherReviewDto);
		
	}
 
	@Override
	public List<GatherReviewVO> listBy(int startRow, int endRow, int gatherIdx) {
	
		Map<String, Object>param = new HashMap<>();
		param.put("startRow", startRow);	
		param.put("endRow", endRow); 	
		param.put("gatherIdx",gatherIdx); 
		
		return sqlSession.selectList("gatherReview.listBy",param);
	}
}
