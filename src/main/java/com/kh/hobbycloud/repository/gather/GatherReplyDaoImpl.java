package com.kh.hobbycloud.repository.gather;

import java.util.List;

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

}
