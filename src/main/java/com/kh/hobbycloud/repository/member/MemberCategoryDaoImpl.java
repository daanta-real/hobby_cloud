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

	@Override
	public void save(MemberCategoryDto memberCategoryDto) {		
		sqlSession.insert("memberCategory.save", memberCategoryDto);		
	}
	
	// memberIdx로 memberCategoryDto 불러오기
	@Override
	public MemberCategoryDto getByMemberIdx(int memberIdx) {
		return sqlSession.selectOne("MemberCategory.getByIdx", memberIdx);
	}
	
	// 한 회원의 선호파일 데이터를 불러오기
	
	
	
	//삭제
	@Override
	public void delete(int memberIdx) {
		sqlSession.delete("MemberCategory.delete",memberIdx);		
	}

	
}

