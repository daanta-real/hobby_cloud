package com.kh.hobbycloud.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;

@Repository
public class MemberCategoryDaoImpl implements MemberCategoryDao{
	
	// 변수선언부
	@Autowired
	private SqlSession sqlSession;

	// 추가
	@Override
	public void insert(MemberCategoryDto memberCategoryDto) {
		sqlSession.insert("memberCategory.insert", memberCategoryDto);
	}

	//단일 조회
	@Override
	public MemberCategoryDto get(Integer memberIdx) {
		return sqlSession.selectOne("memberCategory.select", memberIdx);
	}

	// 수정
	@Override
	public boolean update(MemberCategoryDto memberCategoryDto) {
		int count = sqlSession.update("memberCategory.update", memberCategoryDto);
		System.out.println(count+"카운트개수");
		return count > 0;
	}

	// 삭제
	@Override
	public void delete(Integer memberIdx) {
		sqlSession.delete("memberCategory.delete", memberIdx);		
	}
	
}

