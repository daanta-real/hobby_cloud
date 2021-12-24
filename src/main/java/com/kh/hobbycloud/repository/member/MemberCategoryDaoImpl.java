package com.kh.hobbycloud.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;

//@Repository
public class MemberCategoryDaoImpl implements MemberCategoryDao{

	@Autowired
	private SqlSession sqlSession;
	
	//가입
	@Override
	public void join(MemberCategoryDto memberCategoryDto) {
			sqlSession.insert("memberCategory.insert", memberCategoryDto);
		}
		
	}

