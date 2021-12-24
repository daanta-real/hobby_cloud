package com.kh.hobbycloud.repository.gather;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherDto;

@Repository
public class GatherImpl implements GatherDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GatherDto> listSearch(Map<String, Object> param) {
		return sqlSession.selectList("gather.listSearch", param);
	}

	@Override
	public List<GatherDto> list() {

		return sqlSession.selectList("gather.list");
	}

	@Override
	public void insert(GatherDto gatherDto) {
		sqlSession.insert("gather.insert", gatherDto);

	}

}
