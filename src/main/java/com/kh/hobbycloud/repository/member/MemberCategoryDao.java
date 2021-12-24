package com.kh.hobbycloud.repository.member;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;

public interface MemberCategoryDao {
	
	//가입
	void join(MemberCategoryDto memberCategoryDto);

}
