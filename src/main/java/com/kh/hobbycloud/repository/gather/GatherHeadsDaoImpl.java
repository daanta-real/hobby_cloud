package com.kh.hobbycloud.repository.gather;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherHeadsDto;
import com.kh.hobbycloud.vo.gather.GatherHeadsVO;

@Repository
public class GatherHeadsDaoImpl implements GatherHeadsDao {

	@Autowired
	private SqlSession sqlSession;
	//소모임 참가
	@Override
	public void join(GatherHeadsDto gatherHeadsDto) {
		sqlSession.insert("gatherHeads.join",gatherHeadsDto);
		
	}
	
	//소모임 조회
	@Override
	public List<GatherHeadsVO> list(int gatherIdx) {
		return sqlSession.selectList("gatherHeads.list",gatherIdx);
	}
	
	//소모임 취소
	@Override
	public boolean cancel(GatherHeadsDto gatherHeadsDto) {
		int count =  sqlSession.delete("gatherHeads.cancel",gatherHeadsDto);
		return count>0;
	}
}
