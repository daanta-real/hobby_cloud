package com.kh.hobbycloud.repository.lec;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.vo.lec.LecDetailVO;

@Repository
public class LecDaoImpl implements LecDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void register(LecDto lecDto) {
		sqlSession.insert("lec.register", lecDto);
	}
	
	@Override
	public List<LecDto> listSearch(Map<String, Object> param) {
		return sqlSession.selectList("lec.listSearch", param);
	}
	
	@Override
	public LecDetailVO get(int lecIdx) {
		return sqlSession.selectOne("lec.get", lecIdx);
	}
	
	@Override
	public void delete(int lecIdx) {
		sqlSession.delete("lec.delete", lecIdx);
	}
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("lec.seq");
	}
}
