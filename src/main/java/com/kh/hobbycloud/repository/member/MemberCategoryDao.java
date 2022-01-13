package com.kh.hobbycloud.repository.member;

import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;

@Repository
public interface MemberCategoryDao {
		
	public void insert(MemberCategoryDto memberCategoryDto);

	MemberCategoryDto get(Integer memberIdx); 

	public boolean update(MemberCategoryDto memberCategoryDto);

	public void delete(Integer memberIdx);

//	List<String> select();

}
