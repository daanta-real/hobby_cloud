package com.kh.hobbycloud.repository.tutor;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TutorDaoImpl implements TutorDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(int memberIdx) {
		sqlSession.insert("tutor.insert", memberIdx);
	}
	
	@Override
	public void update(int tutorIdx) {
		sqlSession.update("tutor.update", tutorIdx);
	}
	
	@Override
	public void delete(int memberIdx) {
		sqlSession.delete("tutor.delete", memberIdx);
	}
	
	@Override
	public int getTutorIdx(int memberIdx) {
		return sqlSession.selectOne("tutor.getTutorIdx", memberIdx);
	}
	
}
