package com.kh.hobbycloud.repository.gather;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherReplyDto;
import com.kh.hobbycloud.vo.gather.GatherReplyVO;


@Repository
public class GatherReplyDaoImpl implements GatherReplyDao {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public void insert(GatherReplyDto gatherReplyDto) {
		
		sqlSession.insert("gather.replyInsert",gatherReplyDto);
		
	}
	@Override
	public List<GatherReplyVO> list(int gatherIdx) {
		return sqlSession.selectList("gather.replyList",gatherIdx);
	}
	@Override
	public boolean delete(int gatherReplyIdx) {
		int count = sqlSession.delete("gather.replyDelete",gatherReplyIdx);
		return count >0;
	}
	@Override
	public void edit(GatherReplyDto gatherReplyDto) {
		//댓글 수정 void도 가능
		 sqlSession.update("gather.replyEdit",gatherReplyDto);
	}
	@Override
	public List<GatherReplyVO> listBy(int startRow, int endRow, int gatherIdx) {
		
		Map<String, Object>param = new HashMap<>();
		param.put("startRow", startRow);
		System.out.println("댓글start"+startRow+endRow);
		param.put("endRow", endRow); 
		param.put("gatherIdx",gatherIdx); 
		return sqlSession.selectList("gather.replyList",param); 
	}

}
