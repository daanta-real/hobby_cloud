package com.kh.hobbycloud.repository.gather;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.vo.gather.GatherVO;

@Repository
public class GatherDaoImpl implements GatherDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GatherVO> listSearch(Map<String, Object> param) {
		return sqlSession.selectList("gather.listSearch", param);
	}

	@Override
	public List<GatherVO> list() {
		return sqlSession.selectList("gather.list");
	}

	@Override
	public void insert(GatherDto gatherDto) {
		sqlSession.insert("gather.insert", gatherDto);
	}

	@Override
	public GatherVO get(int gatherIdx) {
		
		return sqlSession.selectOne("gather.get",gatherIdx);
	}

	@Override
	public int getSequence() {		
		return sqlSession.selectOne("gather.getSequence");
	}

	@Override
	public void delete(int gatherIdx) {
	sqlSession.delete("gather.delete",gatherIdx);
	
	}
	

}
