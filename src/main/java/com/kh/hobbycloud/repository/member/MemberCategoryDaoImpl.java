package com.kh.hobbycloud.repository.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.vo.lec.LecCategoryUpdateVO;

@Repository
public class MemberCategoryDaoImpl implements MemberCategoryDao{
	
	// 변수선언부
	@Autowired
	private SqlSession sqlSession;

//	@Override
//	public void save(MemberCategoryDto memberCategoryDto) {		
//		sqlSession.insert("memberCategory.save", memberCategoryDto);		
//	}
//	
//	// memberIdx로 memberCategoryDto 불러오기
//	@Override
//	public MemberCategoryDto getByMemberIdx(int memberIdx) {
//		return sqlSession.selectOne("memberCategory.getByIdx", memberIdx);
//	}
//	
//	// 한 회원의 선호파일 데이터를 불러오기
//	
//	//삭제
//	@Override
//	public void delete(int memberIdx) {
//		sqlSession.delete("MemberCategory.delete",memberIdx);		
//	}
	
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
	

	
}

