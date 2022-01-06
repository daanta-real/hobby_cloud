package com.kh.hobbycloud.repository.member;

import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;

@Repository
public interface MemberCategoryDao {
	
	void save(MemberCategoryDto memberCategoryDto);

	MemberCategoryDto getByMemberIdx(int memberIdx);

	void delete(int memberIdx);

}
