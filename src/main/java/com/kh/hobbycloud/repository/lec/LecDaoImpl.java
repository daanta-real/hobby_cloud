package com.kh.hobbycloud.repository.lec;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecDto;

@Repository
public class LecDaoImpl implements LecDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void register(LecDto lecDto) {
		sqlSession.insert("lec.register", lecDto);
	}
	
	@Override
	public List<LecDto> list() {
		return sqlSession.selectList("lec.list");
	}
	
	@Override
	public List<LecDto> listSearch(Map<String, Object> param) {
		return sqlSession.selectList("lec.listSearch", param);
	}
}
