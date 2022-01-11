package com.kh.hobbycloud.repository.member;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.vo.lec.LecCategoryUpdateVO;

@Repository
public interface MemberCategoryDao {
	
//	void save(MemberCategoryDto memberCategoryDto);
//
//	MemberCategoryDto getByMemberIdx(int memberIdx);
//
//	void delete(int memberIdx);
	
	public void insert(String str);

	public List<String> select();

	public int update(LecCategoryUpdateVO vo);

	public void delete(String str);

}
