package com.kh.hobbycloud.repository.lec;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.vo.lec.LecCategoryUpdateVO;

@Repository
public class LecCategoryDaoImpl implements LecCategoryDao {

	@Autowired SqlSession sqlSession;

	// 추가
	@Override
	public void insert(String str) {
		sqlSession.insert("lecCategory.insert", str);
	}

	// 목록획득
	@Override
	public List<String> select() {
		List<String> list = sqlSession.selectList("lecCategory.select");
		return list;
	}

	// 수정
	@Override
	public int update(LecCategoryUpdateVO vo) {
		return sqlSession.update("lecCategory.update", vo);
	}

	// 삭제
	@Override
	public void delete(String str) {
		sqlSession.delete("lecCategory.delete", str);
	}

	// 삭제
}
